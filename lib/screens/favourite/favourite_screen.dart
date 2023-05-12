import 'package:flutter/material.dart';

import 'components/body.dart';

class FavouriteScreen extends StatelessWidget {

  const FavouriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 30),
              child: Text(
                'Love',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            Expanded(child: Body()),
          ],
        ),
      ),
    );
  }
}
