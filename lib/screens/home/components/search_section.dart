import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/controllers/user_controller.dart';
import 'package:your_tours_mobile/screens/search_home/home_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class HomeSearch extends StatelessWidget {
  HomeSearch({
    Key? key,
  }) : super(key: key);

  UserController userController = Get.find<UserController>();

  String _getShortName(String? fullName) {
    if (fullName == null) {
      return '';
    }

    List<String> nameElement = fullName.split(" ");
    return nameElement.last;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome, ${_getShortName(userController.userInfo.value.fullName)}",
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          "Where would you like to go?",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: const Border(
              top: BorderSide(width: 1.0, color: kBody),
              bottom: BorderSide(width: 1.0, color: kBody),
              left: BorderSide(width: 1.0, color: kBody),
              right: BorderSide(width: 1.0, color: kBody),
            ),
          ),
          child: TextField(
            onSubmitted: (value) {
              print(value);
            },
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenWidth(12)),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: "Search location",
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.5),
                ),
                prefixIcon: GestureDetector(
                    onTap: () {
                      print("object");
                    },
                    child: const Icon(Icons.search)),
                suffixIcon: GestureDetector(
                    onTap: () {
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
                            return const SearchHomeScreen();
                          },
                        ),
                      );
                    },
                    child: const Icon(Icons.list_alt_outlined)),
                suffixIconColor: const Color(0xFFFC674E)),
          ),
        ),
      ],
    );
  }
}
