import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:your_tours_mobile/constants.dart';

class ChooseGuestRow extends StatefulWidget {
  final ValueChanged<int> onChangeTap;
  final String title;
  final String description;

  const ChooseGuestRow(
      {Key? key,
      required this.title,
      required this.description,
      required this.onChangeTap})
      : super(key: key);

  @override
  State<ChooseGuestRow> createState() => _ChooseGuestRowState();
}

class _ChooseGuestRowState extends State<ChooseGuestRow> {
  int _num = 0;

  void _handleAddNum() {
    setState(() {
      _num++;
    });
    widget.onChangeTap(_num);
  }

  void _handleMinusNum() {
    int result = _num - 1;
    if (result < 0) {
      result = 0;
    }
    setState(() {
      _num = result;
    });

    widget.onChangeTap(_num);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              widget.description,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
              ),
            )
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    _handleMinusNum();
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/minus_icon.svg",
                    color: kPrimaryColor,
                  )),
              Text(_num.toString()),
              IconButton(
                onPressed: () {
                  _handleAddNum();
                },
                icon: SvgPicture.asset(
                  "assets/icons/add_icon.svg",
                  color: kPrimaryColor,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
