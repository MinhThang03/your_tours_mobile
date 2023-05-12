import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/controllers/user_controller.dart';

class ProfileInformation extends StatelessWidget {
  ProfileInformation({Key? key}) : super(key: key);

  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => ListTile(
              title: const Text(
                'Họ và tên:',
              ),
              subtitle: Text(userController.userInfo.value.fullName ?? ''),
            )),
        Obx(() => ListTile(
              title: const Text(
                'Email:',
              ),
              subtitle: Text(userController.userInfo.value.email ?? ''),
            )),
        Obx(() => ListTile(
              title: const Text(
                'Số điện thoại:',
              ),
              subtitle: Text(userController.userInfo.value.phoneNumber ?? ''),
            )),
        Obx(() => ListTile(
              title: const Text(
                'Địa chỉ:',
              ),
              subtitle: Text(userController.userInfo.value.address ?? ''),
            )),
      ],
    );
  }
}
