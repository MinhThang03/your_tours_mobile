import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:your_tours_mobile/apis/booking_controller.dart';
import 'package:your_tours_mobile/models/responses/book_home_page_response.dart';

import '../../../size_config.dart';
import 'history_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  BookHomePageResponse? _bookingPageResponse;

  @override
  void initState() {
    super.initState();
    _fetchDataBookingPageFromApi();
  }

  @override
  void dispose() {
    _bookingPageResponse = null;
    super.dispose();
  }

  Future<void> _fetchDataBookingPageFromApi() async {
    try {
      final response = await bookingPageController();
      setState(() {
        _bookingPageResponse = response;
      });
    } on FormatException catch (error) {
      AnimatedSnackBar.material(
        error.message,
        type: AnimatedSnackBarType.error,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: (_bookingPageResponse?.data.content.length ?? 0) == 0
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              child: Text(
                "Bạn không có lịch sử đặt",
                style: TextStyle(fontSize: getProportionateScreenWidth(16)),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: getProportionateScreenWidth(10)),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: _bookingPageResponse?.data.content.length ?? 0,
                  itemBuilder: (context, index) {
                    return HistoryCard(
                        bookingInfo: _bookingPageResponse!.data.content[index]);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
    );
  }
}
