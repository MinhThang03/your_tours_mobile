import 'package:flutter/material.dart';

import 'components/body.dart';
import 'components/home_header.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeHeader(),
          Expanded(child: Body()),
        ],
      ),
    );
  }
}
