import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Welcome, Thang",
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          "Where would you like to go?",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: const Border(
              top: BorderSide(width: 1.0, color: kBody),
              bottom: BorderSide(width: 1.0, color: kBody),
              left: BorderSide(width: 1.0, color: kBody),
              right: BorderSide(width: 1.0, color: kBody),
            ),
          ),
          child: TextField(
            onSubmitted: (value) {
              print(value);
            },
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenWidth(12)),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: "Search location",
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.5),
                ),
                prefixIcon: GestureDetector(
                    onTap: () {
                      print("object");
                    },
                    child: const Icon(Icons.search)),
                suffixIcon: const Icon(Icons.list_alt_outlined),
                suffixIconColor: const Color(0xFFFC674E)),
          ),
        ),
      ],
    );
  }
}
