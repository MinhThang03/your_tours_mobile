import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          if (press != null) {
            press!.call();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(color: kSmoke, width: 1),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    icon,
                    color: kSmoke,
                    width: 22,
                  ),
                  const SizedBox(width: 20),
                  Expanded(child: Text(text)),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: kSmoke,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
