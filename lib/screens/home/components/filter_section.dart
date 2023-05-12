import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/controllers/home_select_filter_controller.dart';

import 'home_filter_card_section.dart';
import 'item_filter_section.dart';

class HomeFilter extends StatefulWidget {
  const HomeFilter({Key? key}) : super(key: key);

  @override
  State<HomeFilter> createState() => _HomeFilterState();
}

class _HomeFilterState extends State<HomeFilter> {
  HomeSelectFilterController homeSelectFilterController =
      Get.put(HomeSelectFilterController());

  @override
  void initState() {
    homeSelectFilterController.selectItem('New');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeListItemFilter(),
        const SizedBox(
          height: 16,
        ),
        Obx(() => HomeFilterCardList(
              topic: homeSelectFilterController.content.value,
            )),
      ],
    );
  }
}
