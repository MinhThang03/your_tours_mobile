import 'package:flutter/material.dart';
import 'package:your_tours_mobile/constants.dart';

class PriceOfHomeRow extends StatelessWidget {
  final String title;
  final String content;
  final bool especially;

  const PriceOfHomeRow(
      {Key? key,
      required this.title,
      required this.content,
      required this.especially})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: especially ? kPrimaryColor : null),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                content,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: especially ? kPrimaryColor : null),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
