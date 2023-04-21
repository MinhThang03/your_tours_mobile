import 'package:flutter/material.dart';

import 'components/body.dart';
import 'components/filter_section.dart';

class HistoryBookingScreen extends StatefulWidget {
  const HistoryBookingScreen({super.key});

  @override
  State<HistoryBookingScreen> createState() => _HistoryBookingScreenState();
}

class _HistoryBookingScreenState extends State<HistoryBookingScreen>
    with TickerProviderStateMixin {
  final List<String> listContent = [
    'Active',
    'Completed',
    'Cancelled',
  ];

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: listContent.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

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
      //       'Lịch sử',
      //       style: TextStyle(color: Colors.black, fontSize: 20),
      //     )),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15, bottom: 30),
              child: Text(
                'My Booking',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            HistoryFilterSection(
              tabController: tabController,
              listContent: listContent,
            ),
            Expanded(
                child: Body(
              tabController: tabController,
              listContent: listContent,
            )),
          ],
        ),
      ),
    );
  }
}
