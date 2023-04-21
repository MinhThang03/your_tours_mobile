import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:your_tours_mobile/apis/booking_controller.dart';
import 'package:your_tours_mobile/components/loading_api_widget.dart';
import 'package:your_tours_mobile/components/shimmer_loading.dart';
import 'package:your_tours_mobile/models/responses/book_home_page_response.dart';

import '../../../size_config.dart';
import 'history_card.dart';

class Body extends StatefulWidget {
  final TabController tabController;
  final List<String> listContent;

  const Body({Key? key, required this.tabController, required this.listContent})
      : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  Future<BookHomePageResponse?> _fetchDataBookingPageFromApi(
      String? status) async {
    try {
      return await bookingPageController(status);
    } on FormatException catch (error) {
      if (!mounted) return null;

      AnimatedSnackBar.material(
        error.message,
        type: AnimatedSnackBarType.error,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      ).show(context);
    }
    return null;
  }

  String? getStatus(String title) {
    switch (title) {
      case 'Active':
        return 'ACTIVE';
      case 'Completed':
        return 'COMPLETED';
      case 'Cancelled':
        return 'CANCELLED';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.tabController,
      children: List.generate(
        widget.listContent.length,
        (index) => LoadApiWidget<BookHomePageResponse?>(
            autoCache: true,
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
            fetchDataFunction: _fetchDataBookingPageFromApi(
                getStatus(widget.listContent[index]))),
      ),
    );
  }

  Widget successWidget(BuildContext context, BookHomePageResponse response) {
    return response.data.content.isEmpty
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            child: Text(
              "Bạn không có lịch sử đặt",
              style: TextStyle(fontSize: getProportionateScreenWidth(16)),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            physics: const BouncingScrollPhysics(),
            itemCount: response.data.content.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  HistoryCard(bookingInfo: response.data.content[index]),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              );
            },
          );
  }
}
