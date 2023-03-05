import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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

  int _indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => GestureDetector(
            onTap: () => {
              setState(() {
                _indexSelected = index;
              })
            },
            child: CategoryCard(
              icon: categories[index]["icon"],
              text: categories[index]["text"],
              index: index,
              indexSelected: _indexSelected,
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.index,
    required this.indexSelected,
  }) : super(key: key);

  final String? icon, text;
  final int index, indexSelected;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: widget.index == widget.indexSelected
                ? Colors.grey
                : Colors.white,
            width: widget.index == widget.indexSelected ? 2.0 : 0,
          ),
        ),
      ),
      child: SizedBox(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              height: getProportionateScreenWidth(40),
              width: getProportionateScreenWidth(40),
              child: SvgPicture.asset(widget.icon!),
            ),
            const SizedBox(height: 4),
            FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.text!,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 12,
                    color: widget.index == widget.indexSelected
                        ? const Color(0xFFFF7643)
                        : Colors.black,
                    fontWeight: widget.index == widget.indexSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                )),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}