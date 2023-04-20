import 'package:flutter/material.dart';
import 'package:your_tours_mobile/models/responses/home_info_response.dart';

import 'home_card.dart';

class Body extends StatefulWidget {
  final List<HomeInfo>? homeList;

  const Body({Key? key, required this.homeList}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: widget.homeList == null ? 0 : widget.homeList?.length,
      itemBuilder: (context, index) {
        return HomeCard(
          homeInfo: widget.homeList![index],
        );
      },
    );
  }
}
