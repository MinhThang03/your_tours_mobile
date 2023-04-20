import 'package:flutter/material.dart';

import '../../../constants.dart';

class HomeListItemFilter extends StatelessWidget {
  HomeListItemFilter({Key? key}) : super(key: key);

  final List<String> listContent = ['New', 'Popular', 'Top Rates', 'Trending'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          listContent.length,
          (index) => GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                HomeFilterItem(
                  text: listContent[index].toString(),
                ),
                const SizedBox(
                  width: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeFilterItem extends StatefulWidget {
  final String text;

  const HomeFilterItem({Key? key, required this.text}) : super(key: key);

  @override
  State<HomeFilterItem> createState() => _HomeFilterItemState();
}

class _HomeFilterItemState extends State<HomeFilterItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: kGray, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          widget.text,
          style: const TextStyle(color: kBody),
        ),
      ),
    );
  }
}
