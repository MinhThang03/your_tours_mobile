import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/controllers/search_controller.dart';

import 'components/body.dart';
import 'components/home_header.dart';

class SearchHomeScreen extends StatefulWidget {
  const SearchHomeScreen({Key? key}) : super(key: key);

  @override
  State<SearchHomeScreen> createState() => _SearchHomeScreenState();
}

class _SearchHomeScreenState extends State<SearchHomeScreen> {

  SearchController searchController = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 30, left: 20, right: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        border: Border.all(color: kSmoke, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 1,
                          )
                        ],
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/arrow_left_direction_icon.svg',
                        width: 16,
                        height: 16,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Search',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 0),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/arrow_left_direction_icon.svg',
                      width: 16,
                      height: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const HomeHeader(),
            Obx(() => Expanded(
                    child: Body(
                  amenityId: searchController.amenityId.value,
                  keyword: searchController.keyword.value,
                ))),
          ],
        ),
      ),
    );
  }
}
