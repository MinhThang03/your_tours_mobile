import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'favorite_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: getProportionateScreenWidth(10)),
            ListView.builder(
              shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: 9,
            itemBuilder: (context, index) {
              return FavoriteCard();
            },
          ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
    );
  }
}
