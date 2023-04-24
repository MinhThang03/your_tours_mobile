import 'package:flutter/material.dart';
import 'package:your_tours_mobile/size_config.dart';

import 'categories.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {

  const HomeHeader({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: SearchField()),
        SizedBox(height: SizeConfig.screenHeight * 0.01),
        const Categories(),
      ],
    );
  }
}
