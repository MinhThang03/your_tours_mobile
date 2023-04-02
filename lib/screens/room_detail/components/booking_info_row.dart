import 'package:flutter/material.dart';

class BookingInfoRow extends StatelessWidget {
  final String title;
  final String content;

  const BookingInfoRow({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0, top: 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 16),
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
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
