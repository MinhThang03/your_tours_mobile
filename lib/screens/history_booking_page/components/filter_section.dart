import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/controllers/booking_controller.dart';

import '../../../constants.dart';

class HistoryFilterSection extends StatelessWidget {
  final TabController tabController;
  final List<String> listContent;

  const HistoryFilterSection(
      {Key? key, required this.tabController, required this.listContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(color: kSmoke, width: 1),
          ),
          child: TabBar(
              labelColor: kWhite,
              unselectedLabelColor: kTextColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: kPrimaryColor,
              ),
              controller: tabController,
              tabs: List.generate(
                  listContent.length,
                  (index) => Tab(
                        child: Text(
                          listContent[index],
                        ),
                      )))),
    );

    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 20),
    //   child: Container(
    //     padding: const EdgeInsets.all(8),
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(18.0),
    //       border: Border.all(color: kSmoke, width: 1),
    //     ),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: List.generate(
    //         listContent.length,
    //             (index) => FilterItem(
    //           text: listContent[index].toString(),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class FilterItem extends StatefulWidget {
  final String text;

  const FilterItem({Key? key, required this.text}) : super(key: key);

  @override
  State<FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  BookingSelectFilterController bookingSelectFilterController =
      Get.put(BookingSelectFilterController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          bookingSelectFilterController.setContent(widget.text);
        },
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
                color:
                    bookingSelectFilterController.content.value == widget.text
                        ? kPrimaryColor
                        : Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text(
                widget.text,
                style: TextStyle(
                    color: bookingSelectFilterController.content.value ==
                            widget.text
                        ? kWhite
                        : kTextColor),
              ),
            ),
          ),
        ));
  }
}
