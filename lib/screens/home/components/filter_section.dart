import 'package:flutter/material.dart';

import 'home_filter_card_section.dart';
import 'item_filter_section.dart';

class HomeFilter extends StatefulWidget {
  const HomeFilter({Key? key}) : super(key: key);

  @override
  State<HomeFilter> createState() => _HomeFilterState();
}

class _HomeFilterState extends State<HomeFilter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeListItemFilter(),
        const SizedBox(
          height: 16,
        ),
        HomeFilterCardList(),
      ],
    );
  }
}
