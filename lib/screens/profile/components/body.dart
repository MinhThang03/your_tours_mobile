import 'package:flutter/material.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/models/responses/user_response.dart';
import 'package:your_tours_mobile/screens/profile/components/profile_confirm.dart';
import 'package:your_tours_mobile/screens/profile_view/profile_view_screen.dart';

import '../../../controllers/user_controller.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserInfoResponse? _userInfo;

  @override
  void initState() {
    super.initState();
    _fetchDataUserInfoFromApi();
  }

  Future<void> _fetchDataUserInfoFromApi() async {
    try {
      final response = await getCurrentUserController();
      setState(() {
        _userInfo = response;
      });
    } on FormatException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
        ),
      );
    }
  }

  bool _getStatusOfUser() {
    if (_userInfo == null) {
      return false;
    }

    if (_userInfo!.data?.status == 'ACTIVE') {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(
            avatar: _userInfo?.data?.avatar,
          ),
          const SizedBox(height: 10),
          _userInfo == null
              ? Container()
              : ProfileConfirm(active: _getStatusOfUser()),
          const SizedBox(height: 20),
          _getStatusOfUser() == true
              ? Container()
              : ProfileMenu(
                  text: "Active account",
                  icon: "assets/icons/active_user_icon.svg",
                  press: () => {},
                ),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {
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
                    return ProfileViewScreen();
                  },
                ),
              )
            },
          ),
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
            press: () {},
          ),
        ],
      ),
    );
  }
}
