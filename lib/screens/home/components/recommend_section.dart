import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/controllers/search_controller.dart';
import 'package:your_tours_mobile/controllers/user_controller.dart';
import 'package:your_tours_mobile/screens/search_home/home_screen.dart';

import 'recommend_card.dart';

class HomeRecommend extends StatefulWidget {
  const HomeRecommend({Key? key}) : super(key: key);

  @override
  State<HomeRecommend> createState() => _HomeRecommendState();
}

class _HomeRecommendState extends State<HomeRecommend> {
  UserController userController = Get.find<UserController>();
  SearchController searchController = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Recommended for you",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  searchController
                      .setKeyword(userController.location.value.cityName);
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
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: const Text('View all',
                      style: TextStyle(
                          fontSize: 13,
                          color: kSecondary,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Obx(() => HomeRecommendCardList(
              city: userController.location.value.cityName,
            ))
      ],
    );
  }
}
