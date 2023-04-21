import 'package:flutter/material.dart';

import '../../../constants.dart';

class HistoryFilterSection extends StatelessWidget {
  HistoryFilterSection({Key? key}) : super(key: key);

  final List<String> listContent = [
    'Active',
    'Completed',
    'Cancelled',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(color: kSmoke, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            listContent.length,
            (index) => FilterItem(
              text: listContent[index].toString(),
            ),
          ),
        ),
      ),
    );
  }
}

class FilterItem extends StatefulWidget {
  final String text;

  const FilterItem({Key? key, required this.text}) : super(key: key);

  @override
  State<FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            // color: homeSelectFilterController.content.value == widget.text
            //     ? kPrimaryColor
            //     : kGray,
            color: kPrimaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Text(
            widget.text,
            style: TextStyle(
                // color:
                // homeSelectFilterController.content.value == widget.text
                //     ? kWhite
                //     : kBody
                ),
          ),
        ),
      ),
    );
  }
}
