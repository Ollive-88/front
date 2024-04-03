import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ollive_front/service/user/user_service.dart';
import 'package:ollive_front/util/controller/getx_controller.dart';

class ProfileImageScreen extends StatefulWidget {
  const ProfileImageScreen({super.key});

  @override
  State<ProfileImageScreen> createState() => _ProfileImageScreenState();
}

class _ProfileImageScreenState extends State<ProfileImageScreen> {
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFFFD5D5),
    minimumSize: const Size(0, 55),
    foregroundColor: Colors.black87,
    textStyle: const TextStyle(
      fontSize: 18,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  // 이미지 피커
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImg;
  bool _pickInProgress = false;
  final StatusController _userInfoController = Get.put(StatusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사진 편집'),
        centerTitle: true,
        surfaceTintColor: const Color(0xFFFFFFFC),
        shadowColor: Colors.black,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              updateImage();
            },
            child: const Text(
              '완료',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: ClipOval(
                      child: (_pickedImg == null)
                          ? Image.asset(
                              'assets/image/icons/basic_profile_img.png',
                              width: 250,
                              height: 250,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(_pickedImg!.path),
                              width: 250,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showdialog(context);
                    },
                    style: buttonStyle,
                    child: const Text('사진 편집'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> showdialog(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        title: const Text(
          '프로필 사진',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: SizedBox(
          height: 100,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        await _pickImg();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey,
                        alignment: Alignment.centerLeft,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius
                              .zero, // 테두리를 없애기 위해 BorderRadius.zero로 설정
                        ),
                      ),
                      child: const Text(
                        '앨범에서 사진/동영상 선택',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        deleteImage();
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey,
                        alignment: Alignment.centerLeft,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius
                              .zero, // 테두리를 없애기 위해 BorderRadius.zero로 설정
                        ),
                      ),
                      child: const Text(
                        '기본 이미지로 변경',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 이미지 선택 메서드
  Future<void> _pickImg() async {
    // 이중클릭 방지
    if (_pickInProgress) {
      return;
    }
    _pickInProgress = true;

    // 이미지(XFile)을 받아오고 상태갱신
    XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );

    if (image != null) {
      setState(() {
        _pickedImg = image;
      });
    }
    _pickInProgress = false;
  }

  // 이미지 지우는 메서드
  void deleteImage() {
    setState(() {
      _pickedImg = null;
    });
  }

  void updateImage() async {
    await UserService.convertXFileToMultipartFile(_pickedImg).then((value) {
      UserService.updateProfileImage(['profilePicture', value]).then((value) {
        _userInfoController.setImgUrl((value == null) ? '' : value);
        Navigator.pop(context);
      }).catchError((e) {
        print(e);
      });
    });
  }
}
