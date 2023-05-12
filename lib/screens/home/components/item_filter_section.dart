import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/controllers/home_select_filter_controller.dart';

import '../../../constants.dart';

class HomeListItemFilter extends StatelessWidget {
  HomeListItemFilter({Key? key}) : super(key: key);

  final List<String> listContent = [
    'New',
    'Top Views',
    'Top Rates',
    'Top Booking',
    'Top Like'
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          listContent.length,
          (index) => Row(
            children: [
              HomeFilterItem(
                text: listContent[index].toString(),
              ),
              const SizedBox(
                width: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomeFilterItem extends StatefulWidget {
  final String text;

  const HomeFilterItem({Key? key, required this.text}) : super(key: key);

  @override
  State<HomeFilterItem> createState() => _HomeFilterItemState();
}

class _HomeFilterItemState extends State<HomeFilterItem> {
  HomeSelectFilterController homeSelectFilterController =
      Get.find<HomeSelectFilterController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          homeSelectFilterController.selectItem(widget.text);
        },
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
                color: homeSelectFilterController.content.value == widget.text
                    ? kPrimaryColor
                    : kGray,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                widget.text,
                style: TextStyle(
                    color:
                        homeSelectFilterController.content.value == widget.text
                            ? kWhite
                            : kBody),
              ),
            ),
          ),
        ));
  }
}
