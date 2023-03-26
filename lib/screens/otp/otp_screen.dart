import 'package:flutter/material.dart';
import 'package:your_tours_mobile/size_config.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          title: const Text(
            'OTP Verification',
            style: TextStyle(color: Colors.black, fontSize: 20),
          )),
      body: Body(
        email: email,
      ),
    );
  }
}
