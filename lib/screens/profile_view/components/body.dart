import 'package:flutter/material.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/screens/complete_profile/complete_profile_screen.dart';
import 'package:your_tours_mobile/screens/profile/components/profile_pic.dart';
import 'package:your_tours_mobile/screens/profile_view/components/profile_information.dart';

import '../../../components/default_button.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                ProfilePic(),
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
                          return CompleteProfileScreen();
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
