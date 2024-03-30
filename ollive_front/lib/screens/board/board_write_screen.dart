import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ollive_front/models/board/board_detail_model.dart';
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
  List<String> tagNames = [];
  // 수정 태그 리스트
  List<String> updateTagNames = [];
  List<String> deleteTagNames = [];

  // 이미지 피커
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _pickedImgs = [];
  // 수정 이미지 리스트
  final List<XFile> _updatePickedImgs = [];
  final List<XFile> _deletePickedImgs = [];

  // 태그 입력 처리 메서드
  void subStringTags() {
    String text = _inputController.text;
    RegExp regExp = RegExp(r"[\uAC00-\uD7A3a-zA-Z0-9_]+");
    Iterable<RegExpMatch> matches = regExp.allMatches(text);

    for (var match in matches) {
      text = text.replaceFirst(match.group(0)!, '');
      if (isModify) {
        updateTagNames.add(match.group(0)!);
      }

      tagNames.add(match.group(0)!);
    }
    _inputController.text = text.trim(); // trim()을 사용해 앞뒤 공백 제거
    _scrollToBottom();

    setState(() {});
  }

  // 태그 지우는 메서드
  void deleteTags(int index) {
    if (isModify) {
      deleteTagNames.add(tagNames[index]);
    }
    tagNames.removeAt(index);
    setState(() {});
  }

  // 태그 스크롤 뷰 자동 포커싱
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
    final List<XFile> images = await _picker.pickMultiImage();

    setState(() {
      bool isFull = false;
      for (var image in images) {
        if (_pickedImgs.length < 5) {
          if (isModify) {
            _updatePickedImgs.add(image);
          }
          _pickedImgs.add(image);
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
  void deleteImage(int index) {
    if (isModify) {
      _deletePickedImgs.add(_pickedImgs[index]);
    }
    _pickedImgs.removeAt(index);
    setState(() {});
  }

  static Future<XFile> getImageXFileByUrl(String url) async {
    var file = await DefaultCacheManager().getSingleFile(url);
    return XFile(file.path);
  }

  void addImages() async {
    for (var imgUrl in widget.boardDetail!.images) {
      XFile img = await getImageXFileByUrl(imgUrl);
      _pickedImgs.add(img);
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
          toolbarHeight: MediaQuery.of(context).size.height / 10,
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
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (_titleController.text.isEmpty ||
                      _titleController.text.length > 50 ||
                      _contentController.text.isEmpty) {
                    ErrorService.showToast("제목 혹은 본문을 입력해 주세요");
                    return;
                  }

                  if (!isModify) {
                    List<MultipartFile> imgs =
                        await BoardService.convertXFileToMultipartFile(
                            _pickedImgs);

                    int result = await BoardService.postBoard(
                        _titleController.text,
                        tagNames,
                        _contentController.text,
                        imgs);
                    if (result == 0) {
                      ErrorService.showToast("잘못된 요청입니다.");
                    } else {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false);
                    }
                  } else {
                    List<MultipartFile> updateImages =
                        await BoardService.convertXFileToMultipartFile(
                            _updatePickedImgs);

                    List<MultipartFile> deleteImages =
                        await BoardService.convertXFileToMultipartFile(
                            _deletePickedImgs);
                    int result = await BoardService.fatchBoard(
                      updateTagNames,
                      deleteTagNames,
                      updateImages,
                      deleteImages,
                      _titleController.text,
                      _contentController.text,
                    );

                    if (result == 0) {
                      ErrorService.showToast("잘못된 요청입니다.");
                    } else {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false);
                    }
                  }
                  // ignore: unrelated_type_equality_checks
                },
                child: const Text(
                  "완료",
                  style: TextStyle(
                    fontSize: 24,
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
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom / 4,
                    right: 15,
                    left: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          hintText: "제목을 입력하세요",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
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
                              width: 3, // 밑줄의 두께를 지정하세요
                            ),
                          ),
                        ),
                        height: MediaQuery.of(context).size.height / 2,
                        child: TextFormField(
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
                      RawKeyboardListener(
                        focusNode: _focusNode,
                        onKey: (event) {
                          if (event.physicalKey.debugName == "Space") {
                            subStringTags();
                          }
                        },
                        child: TextFormField(
                          controller: _inputController,
                          decoration: const InputDecoration(
                            hintText: "태그를 입력하세요",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 5),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (int i = 0; i < tagNames.length; i++)
                                Tag(
                                  tagName: tagNames[i],
                                  isSearch: true,
                                  deleteTag: () => deleteTags(i),
                                )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: keyboardHeight,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFC),
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFEBEBE9),
                      width: 3,
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
                        SingleChildScrollView(
                          child: Row(
                            children: [
                              for (var i = 0; i < _pickedImgs.length; i++)
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: BoardImage(
                                    image: _pickedImgs[i],
                                    heght:
                                        MediaQuery.of(context).size.height / 10,
                                    deleteImage: () => deleteImage(i),
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
