import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:your_tours_mobile/controllers/user_controller.dart';

import '../../../constants.dart';

class ProfilePicSelected extends StatefulWidget {
  final ValueChanged<String?> selectedImage;

  const ProfilePicSelected({Key? key, required this.selectedImage})
      : super(key: key);

  @override
  State<ProfilePicSelected> createState() => _ProfilePicSelectedState();
}

class _ProfilePicSelectedState extends State<ProfilePicSelected> {
  UserController userController = Get.find<UserController>();

  String _path = '';
  late String? origin;

  @override
  void initState() {
    origin = userController.userInfo.value.avatar;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            child: _path == ''
                ? Image.network(
                    userController.userInfo.value.avatar ??
                        'https://static.vecteezy.com/system/resources/thumbnails/002/002/403/small/man-with-beard-avatar-character-isolated-icon-free-vector.jpg',
                    fit: BoxFit.cover,
                  )
                : Image.file(File(_path), fit: BoxFit.cover),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: GestureDetector(
              onTap: () async {
                selectImage();
                setState(() {});
              },
              child: SizedBox(
                height: 46,
                width: 46,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(color: Colors.white),
                    ),
                    backgroundColor: const Color(0xFFF5F6F9),
                  ),
                  onPressed: () async {
                    selectImage();
                    setState(() {});
                  },
                  child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Chọn ảnh từ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            _path = await selectImageFromGallery();

                            if (!mounted) {
                              return;
                            }

                            if (_path != '') {
                              widget.selectedImage(_path);
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              AnimatedSnackBar.material(
                                'Không có hình ảnh được chọn',
                                type: AnimatedSnackBarType.error,
                                mobileSnackBarPosition:
                                    MobileSnackBarPosition.bottom,
                                desktopSnackBarPosition:
                                    DesktopSnackBarPosition.topRight,
                              ).show(context);
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Icon(Icons.image,
                                        size: 25, color: kPrimaryColor),
                                    Text('Thư viện'),
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            _path = await selectImageFromCamera();

                            if (!mounted) {
                              return;
                            }

                            if (_path != '') {
                              widget.selectedImage(_path);
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("No Image Captured !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 25,
                                      color: kPrimaryColor,
                                    ),
                                    Text('Camera'),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  //
  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
}
