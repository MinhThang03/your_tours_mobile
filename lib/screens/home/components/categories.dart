import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
      {"icon": "assets/icons/Bill Icon.svg", "text": "Bill"},
      {"icon": "assets/icons/Game Icon.svg", "text": "Game"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "Daily Gift"},
      {"icon": "assets/icons/Discover.svg", "text": "More"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "More"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "More"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "More"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "More"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "More"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "More"},
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {},
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              height: getProportionateScreenWidth(40),
              width: getProportionateScreenWidth(40),
              child: SvgPicture.asset(icon!),
            ),
            SizedBox(height: 4),
            FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  text!,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(fontSize: 12),
                ))
          ],
        ),
      ),
    );
  }
}
