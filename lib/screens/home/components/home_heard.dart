import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:your_tours_mobile/constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          child: Image.network(
            "https://static.vecteezy.com/system/resources/thumbnails/002/002/403/small/man-with-beard-avatar-character-isolated-icon-free-vector.jpg",
            fit: BoxFit.cover,
            height: 50,
            width: 50,
          ),
        ),
        Expanded(
            child: Column(
              children: [
                const Text(
                  "Your location",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/location.svg',
                      width: 18,
                      height: 18,
                      color: const Color(0xFFFC674E),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      "Ho Chi Minh",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    SvgPicture.asset(
                      'assets/icons/down_arrow_icon.svg',
                      width: 12,
                      height: 12,
                    ),
                  ],
                )
              ],
            )),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            child: Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryColor,
              ),
              child: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
