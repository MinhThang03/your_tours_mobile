import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/controllers/user_controller.dart';
import 'package:your_tours_mobile/models/responses/user_response.dart';
import 'package:your_tours_mobile/screens/sign_in/sign_in_screen.dart';
import 'package:your_tours_mobile/services/token_handler.dart';

import 'profile_info_section.dart';
import 'profile_menu.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  UserController userController = Get.find<UserController>();

  bool _getStatusOfUser(UserInfo? userInfo) {
    if (userInfo == null) {
      return false;
    }

    if (userInfo.status == 'ACTIVE') {
      return true;
    }

    return false;
  }

  Future<void> handleLogOut() async {
    await deleteToken();
    Get.deleteAll();

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ProfileInfoSection(),
          const SizedBox(height: 20),
          Obx(() => _getStatusOfUser(userController.userInfo.value)
              ? Container()
              : ProfileMenu(
                  text: "Active account",
                  icon: "assets/icons/active_user_icon.svg",
                  press: () => {},
                )),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              handleLogOut();
            },
          ),
        ],
      ),
    );
  }
}
