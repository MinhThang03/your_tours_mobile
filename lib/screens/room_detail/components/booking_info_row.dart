import 'package:flutter/material.dart';

class BookingInfoRow extends StatelessWidget {
  final String title;
  final String content;

  const BookingInfoRow({Key? key, required this.title, required this.content})
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
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                content,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
