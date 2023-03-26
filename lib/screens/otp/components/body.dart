import 'package:flutter/material.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/size_config.dart';

import 'otp_form.dart';

class Body extends StatelessWidget {
  final String email;

  const Body({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                "OTP Verification",
                style: headingStyle,
              ),
              Container(
                  alignment: Alignment.center,
                  child: Text("We sent your code to email $email")),
              buildTimer(),
              const OtpForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: () {
                  // OTP code resend
                },
                child: const Text(
                  "Resend OTP Code",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: const Duration(seconds: 120), end: Duration.zero),
          duration: const Duration(seconds: 120),
          builder: (_,  value, child) => Text(
            "${value.inMinutes % 60}:${value.inSeconds % 60}",
            style: const TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
