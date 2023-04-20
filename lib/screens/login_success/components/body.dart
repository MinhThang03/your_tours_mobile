import 'package:flutter/material.dart';
import 'package:your_tours_mobile/components/default_button.dart';
import 'package:your_tours_mobile/screens/main_screen/main_screen.dart';
import 'package:your_tours_mobile/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "Login Success",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Back to search_home",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MainScreen(selectedInit: 0)),
              );
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
