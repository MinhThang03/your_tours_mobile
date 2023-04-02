import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingCardInfoRow extends StatelessWidget {
  final String icon;
  final String title;
  final String content;

  const BookingCardInfoRow(
      {Key? key,
      required this.icon,
      required this.title,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 18,
                height: 18,
              ),
              const SizedBox(width: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        Expanded(
          child: Text(
            content,
            style: const TextStyle(fontSize: 12),
          ),
        )
      ],
    );
  }
}
