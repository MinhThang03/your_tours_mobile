import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:your_tours_mobile/apis/booking_controller.dart';
import 'package:your_tours_mobile/components/loading_api_widget.dart';
import 'package:your_tours_mobile/components/shimmer_loading.dart';
import 'package:your_tours_mobile/models/responses/book_home_page_response.dart';

import '../../../size_config.dart';
import 'history_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  Future<BookHomePageResponse?> _fetchDataBookingPageFromApi() async {
    try {
      return await bookingPageController();
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
    return LoadApiWidget<BookHomePageResponse?>(
        successBuilder: (context, response) {
          return successWidget(context, response!);
        },
        loadingBuilder: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              children: List.generate(
                  3,
                  (index) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: ShimmerLoadingFavorite(
                          width: 120,
                          height: 120,
                          boxShape: BoxShape.rectangle,
                        ),
                      )),
            ),
          ),
        ),
        fetchDataFunction: _fetchDataBookingPageFromApi());
  }

  Widget successWidget(BuildContext context, BookHomePageResponse response) {
    return SingleChildScrollView(
      child: response.data.content.isEmpty
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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: response.data.content.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          HistoryCard(
                              bookingInfo: response.data.content[index]),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
      ),
    );
  }
}
