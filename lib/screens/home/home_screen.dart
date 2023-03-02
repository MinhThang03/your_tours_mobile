import 'package:flutter/material.dart';

import '../../size_config.dart';
import 'components/body.dart';
import 'components/categories.dart';
import 'components/home_header.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
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
                HomeHeader(),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Categories(),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
              ],
            ),
          ),
          Expanded(child: Body()),
        ],
      ),
    );
  }
}
