import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ollive_front/models/board/board_detail_model.dart';
import 'package:ollive_front/models/board/image_model.dart';
import 'package:ollive_front/models/board/tag_model.dart';
import 'package:ollive_front/service/board/board_service.dart';
import 'package:ollive_front/util/error/error_service.dart';
import 'package:ollive_front/widgets/board/board_image_widget.dart';
import 'package:ollive_front/widgets/board/board_tag_widget.dart';

// ignore: must_be_immutable
class BoardWriteScreen extends StatefulWidget {
  BoardWriteScreen({super.key, this.boardDetail});
  BoardDetailModel? boardDetail;
  @override
  State<BoardWriteScreen> createState() => _BoardWriteScreenState();
}

class _BoardWriteScreenState extends State<BoardWriteScreen> {
  late bool isModify;
  // 키보드 위치 변수
  double keyboardHeight = 0.0;
  // 태그 입력 컨트롤
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _inputController = TextEditingController();
  // 태그 스크롤 컨트롤
  final ScrollController _scrollController = ScrollController();
  // 태그 포커스 노드
  final FocusNode _focusNode = FocusNode();
  // 태그 리스트
  List<TagModel> tagNames = [];
  // 수정 태그 리스트
  List<TagModel> updateTagNames = [];
  List<int> deleteTagNames = [];

  // 이미지 피커
  final ImagePicker _picker = ImagePicker();
  final List<ImageDetailModel> _pickedImgs = [];
  // 수정 이미지 리스트
  final List<ImageDetailModel> _updatePickedImgs = [];
  final List<int> _deletePickedImgs = [];
  bool isComplet = false;

  // 태그 입력 처리 메서드
  void _handleInput(String input) {
    if (input.endsWith(' ')) {
      String tagName = input.trim();
      if (tagName.isNotEmpty) {
        setState(() {
          tagNames.add(TagModel(tagName));
          _inputController.clear();
        });
        Timer(const Duration(milliseconds: 50), () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        });
      }
    }
  }

  // 태그 지우는 메서드
  void deleteTags(TagModel tagModel, int i) {
    if (tagModel.id != null) {
      deleteTagNames.add(tagModel.id!);
    }

    tagNames.removeAt(i);

    setState(() {});
  }

  // 태그 스크롤 뷰 자동 포커싱
  // ignore: unused_element
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent +
          100, // 100은 추가될 항목의 대략적인 높이입니다.
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  // 이미지 선택 메서드
  Future<void> _pickImg() async {
    final List<XFile> images = await _picker.pickMultiImage(
      imageQuality: 30,
    );

    setState(() {
      bool isFull = false;
      for (var image in images) {
        if (_pickedImgs.length < 5) {
          if (isModify) {
            _updatePickedImgs.add(ImageDetailModel(imgFile: image));
          }
          _pickedImgs.add(ImageDetailModel(imgFile: image));
        } else {
          isFull = true;
        }
      }

      if (isFull) {
        ErrorService.showToast("이미지를 5장 이상 추가할 수 없습니다.");
      }
    });
  }

  // 이미지 지우는 메서드
  void deleteImage(ImageDetailModel imageDetailModel, int index) {
    if (isModify && imageDetailModel.id != null) {
      _deletePickedImgs.add(imageDetailModel.id!);
    }
    _pickedImgs.removeAt(index);
    setState(() {});
  }

  static Future<XFile> getImageXFileByUrl(String url) async {
    var file = await DefaultCacheManager().getSingleFile(url);
    return XFile(file.path);
  }

  void addImages() async {
    for (var img in widget.boardDetail!.images) {
      XFile temp = await getImageXFileByUrl(img.address);
      _pickedImgs.add(
          ImageDetailModel(imgFile: temp, id: img.id, address: img.address));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    if (widget.boardDetail != null) {
      isModify = true;
    } else {
      isModify = false;
    }

    // 포커스 초기화
    _focusNode.requestFocus();

    // 키보드 상태 변화 감지
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewInsets = MediaQuery.of(context).viewInsets.bottom;
      if (viewInsets != keyboardHeight) {
        setState(() {
          keyboardHeight = viewInsets;
        });
      }
    });

    // 게시글 수정일 때 입력창 값들 초기화
    if (isModify) {
      _titleController.text = widget.boardDetail!.title;
      _contentController.text = widget.boardDetail!.content;
      tagNames.addAll(widget.boardDetail!.tags);

      addImages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFC),
        appBar: AppBar(
          centerTitle: true,
          surfaceTintColor: const Color(0xFFFFFFFC),
          shadowColor: Colors.black,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center, // 수직 방향 중앙 정렬
            children: [
              const Expanded(
                child: Text(
                  "글쓰기",
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (!isComplet) {
                    isComplet = true;
                    if (_titleController.text.isEmpty ||
                        _titleController.text.length > 50 ||
                        _contentController.text.isEmpty) {
                      ErrorService.showToast("제목 혹은 본문을 입력해 주세요");
                      return;
                    }

                    if (!isModify) {
                      List<XFile> imgList = [];

                      for (var i = 0; i < _pickedImgs.length; i++) {
                        imgList.add(_pickedImgs[i].imgFile);
                      }
                      List<MultipartFile> imgs =
                          await BoardService.convertXFileToMultipartFile(
                              imgList);

                      List<String> tagList = [];

                      for (var i = 0; i < tagNames.length; i++) {
                        tagList.add(tagNames[i].tagName);
                      }

                      await BoardService.postBoard(_titleController.text,
                              tagList, _contentController.text, imgs)
                          .then((value) => Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (route) => false))
                          .catchError((e) {
                        ErrorService.showToast("잘못된 요청입니다.");
                        return null;
                      });
                    } else {
                      // 추가된 태그 목록 초기화
                      List<String> updateTagList = [];

                      for (var i = 0; i < updateTagNames.length; i++) {
                        updateTagList.add(updateTagNames[i].tagName);
                      }

                      // 추가된 이미지 초기화
                      List<XFile> updateImgList = [];

                      for (var i = 0; i < _updatePickedImgs.length; i++) {
                        updateImgList.add(_updatePickedImgs[i].imgFile);
                      }

                      List<MultipartFile> updateImages =
                          await BoardService.convertXFileToMultipartFile(
                              updateImgList);

                      await BoardService.fatchBoard(
                        widget.boardDetail!.boardId,
                        updateTagList,
                        deleteTagNames,
                        updateImages,
                        _deletePickedImgs,
                        _titleController.text,
                        _contentController.text,
                      ).then((value) {
                        isComplet = false;
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/home', (route) => false);
                      }).catchError((e) {
                        ErrorService.showToast("잘못된 요청입니다.");
                        return null;
                      });
                    }
                  }
                },
                child: const Text(
                  "완료",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          shape: const Border(
            bottom: BorderSide(
              width: 2,
              color: Color(0xFFEBEBE9),
            ),
          ),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        style: const TextStyle(
                          fontSize: 17.0, // 텍스트 크기
                          fontWeight: FontWeight.w600, // 텍스트 두께
                        ),
                        controller: _titleController,
                        decoration: const InputDecoration(
                          hintText: "제목을 입력하세요",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Color(0xFFEBEBE9),
                            ),
                          ),
                          // 포커스를 받았을 때의 테두리 스타일
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Color(0xFFEBEBE9),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFEBEBE9), // 여기서 원하는 색상을 선택하세요
                              width: 2, // 밑줄의 두께를 지정하세요
                            ),
                          ),
                        ),
                        height: MediaQuery.of(context).size.height / 2,
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 15.0, // 텍스트 크기
                            fontWeight: FontWeight.w500, // 텍스트 두께
                          ),
                          controller: _contentController,
                          maxLines: 100,
                          decoration: const InputDecoration(
                            hintText: "내용을 입력하세요",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      // ignore: deprecated_member_use
                      TextFormField(
                        onChanged: _handleInput,
                        style: const TextStyle(
                          fontSize: 15.0, // 텍스트 크기
                          fontWeight: FontWeight.w500, // 텍스트 두께
                        ),
                        controller: _inputController,
                        decoration: const InputDecoration(
                          hintText: "태그 입력 시 각 태그는 띄어쓰기로 구분해 주세요.",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 5),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(tagNames.length, (index) {
                              return Row(
                                children: [
                                  Tag(
                                    tagModel: tagNames[index],
                                    isSearch: true,
                                    deleteTag: () =>
                                        deleteTags(tagNames[index], index),
                                  ),
                                  const SizedBox(
                                      width: 8), // 각 Tag 위젯 사이에 공백 추가
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SingleChildScrollView(
                        child: Row(
                          children: [
                            for (var i = 0; i < _pickedImgs.length; i++)
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: BoardImage(
                                  image: _pickedImgs[i].imgFile,
                                  heght:
                                      MediaQuery.of(context).size.height / 10,
                                  deleteImage: () =>
                                      deleteImage(_pickedImgs[i], i),
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          constraints: const BoxConstraints(minHeight: 48),
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xFFE5E5EA),
              ),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.image),
                    color: Colors.black,
                    onPressed: () {
                      _pickImg();
                    },
                  ),
                  const Text(
                    '사진',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
