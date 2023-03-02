import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'home_header.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeHeader(),
          SizedBox(height: getProportionateScreenWidth(10)),
        ],
      ),
    );
  }
}
