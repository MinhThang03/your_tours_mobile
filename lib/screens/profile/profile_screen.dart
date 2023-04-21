import 'package:flutter/material.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     automaticallyImplyLeading: false,
      //     elevation: 1,
      //     backgroundColor: Colors.white,
      //     iconTheme: const IconThemeData(
      //       color: Colors.black, //change your color here
      //     ),
      //     centerTitle: true,
      //     title: const Text(
      //       'Hồ sơ',
      //       style: TextStyle(color: Colors.black, fontSize: 20),
      //     )),
      body: SafeArea(
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 30),
              child: Text(
                'Profile',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            Body(),
          ],
        ),
      ),
    );
  }
}
