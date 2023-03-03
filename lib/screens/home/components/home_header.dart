import 'package:flutter/material.dart';
import 'package:your_tours_mobile/size_config.dart';

import 'categories.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          SizedBox(height: SizeConfig.screenHeight * 0.01),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: SearchField()),
          SizedBox(height: SizeConfig.screenHeight * 0.01),
          Categories(),
          SizedBox(height: SizeConfig.screenHeight * 0.01),
        ],
      ),
    );
  }
}
