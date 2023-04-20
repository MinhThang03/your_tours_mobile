import 'package:flutter/material.dart';
import 'package:your_tours_mobile/constants.dart';

import 'recommend_card.dart';

class HomeRecommend extends StatefulWidget {
  const HomeRecommend({Key? key}) : super(key: key);

  @override
  State<HomeRecommend> createState() => _HomeRecommendState();
}

class _HomeRecommendState extends State<HomeRecommend> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Recommended for you",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    child: const Text('View all',
                        style: TextStyle(
                            fontSize: 13,
                            color: kSecondary,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        const HomeRecommendCardList()
      ],
    );
  }
}
