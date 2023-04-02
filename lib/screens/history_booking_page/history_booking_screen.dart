import 'package:flutter/material.dart';

import 'components/body.dart';

class HistoryBookingScreen extends StatelessWidget {
  const HistoryBookingScreen({super.key});

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
            'Lịch sử',
            style: TextStyle(color: Colors.black, fontSize: 20),
          )),
      body: const Body(),
    );
  }
}
