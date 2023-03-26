import 'package:flutter/material.dart';

import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          title: const Text(
            'Đăng nhập',
            style: TextStyle(color: Colors.black, fontSize: 20),
          )),
      body: const Body(),
    );
  }
}
