import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/controllers/user_controller.dart';
import 'package:your_tours_mobile/screens/complete_profile/complete_profile_screen.dart';
import 'package:your_tours_mobile/screens/profile/components/profile_pic.dart';
import 'package:your_tours_mobile/screens/profile_view/components/profile_information.dart';

import '../../../components/default_button.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() =>
                    ProfilePic(avatar: userController.userInfo.value.avatar)),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                ProfileInformation(),
                SizedBox(height: getProportionateScreenHeight(30)),
                DefaultButton(
                  text: "Chỉnh sửa thông tin",
                  press: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: timeNavigatorPush,
                        transitionsBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                            Widget child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return const CompleteProfileScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
