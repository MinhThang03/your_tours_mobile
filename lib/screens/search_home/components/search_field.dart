import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/controllers/search_controller.dart';

import '../../../size_config.dart';

class SearchField extends StatelessWidget {
  SearchField({
    Key? key,
  }) : super(key: key);

  SearchController searchController = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Đặt shadow theo chiều dọc
          ),
        ],
      ),
      child: TextField(
        onSubmitted: (value) {
          searchController.setKeyword(value);
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(12)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Bạn sẽ đi đâu?",
            prefixIcon: const Icon(Icons.search)),
      ),
    );
  }
}
