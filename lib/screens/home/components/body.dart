import 'package:flutter/material.dart';

import 'city_section.dart';
import 'filter_section.dart';
import 'home_heard.dart';
import 'recommend_section.dart';
import 'search_section.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            const HomeHeader(),
            const SizedBox(
              height: 30,
            ),
            HomeSearch(),
            const SizedBox(
              height: 15,
            ),
            const HomeCity(),
            const SizedBox(
              height: 25,
            ),
            const HomeFilter(),
            const SizedBox(
              height: 25,
            ),
            const HomeRecommend(),
          ],
        ),
      ),
    );
  }
}
