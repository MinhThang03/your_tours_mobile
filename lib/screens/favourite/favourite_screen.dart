import 'package:flutter/material.dart';

import 'components/body.dart';

class FavouriteScreen extends StatelessWidget {
  static String routeName = "/favourite";

  const FavouriteScreen({super.key});
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
            'Yêu thích',
            style: TextStyle(
                color: Colors.black, fontSize: 24),
          )),
      body: const Body(),
    );
  }
}
