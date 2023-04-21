import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:your_tours_mobile/apis/booking_controller.dart';
import 'package:your_tours_mobile/models/requests/cancel_booking_request.dart';
import 'package:your_tours_mobile/models/responses/book_home_page_response.dart';
import 'package:your_tours_mobile/screens/main_screen/main_screen.dart';
import 'package:your_tours_mobile/services/handle_date_time.dart';
import 'package:your_tours_mobile/services/handle_province_name.dart';

import '../../../components/loading_overlay.dart';
import '../../../constants.dart';

class HistoryCard extends StatefulWidget {
  final BookingInfo bookingInfo;

  const HistoryCard({Key? key, required this.bookingInfo}) : super(key: key);

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {

  Future<void> _handleCancelBookingApi() async {
    try {
      CancelBookingRequest request =
      CancelBookingRequest(bookingId: widget.bookingInfo.id);

      await LoadingOverlay.of(context)
          .during(future: cancelBookingPageController(request));

      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
      showPopupSuccess(context);
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
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: kPrimaryColor, width: 1),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(18.0)),
            child: Image.network(
              widget.bookingInfo.thumbnail,
              fit: BoxFit.cover,
              height: 120,
              width: 100,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.bookingInfo.homeName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/location_fill_icon.svg',
                        width: 18,
                        height: 18,
                        color: kSmoke,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        getShortProvinceName("Ho Chi Minh"),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),

                  Text(
                    '${getDayMonthFormat(widget.bookingInfo.dateStart.toString())} - ${getDayMonthFormat(widget.bookingInfo.dateEnd.toString())}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  Text(
                    '${widget.bookingInfo.totalCost.toInt()} VNĐ',
                    style: const TextStyle(
                        color: kSecondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),

                  // BookingCardInfoRow(
                  //   icon: 'assets/icons/check_out.svg',
                  //   title: 'Ngày đi:',
                  //   content: DateFormat('dd-MM-yyyy')
                  //       .format(widget.bookingInfo.dateEnd),
                  // ),
                ],
              ),
            ),
          ),
          SvgPicture.asset(
            'assets/icons/arrow_forward_right_icon.svg',
            color: kSecondaryColor,
            width: 22,
          ),
        ],
      ),
    );
  }

  void showPopupCancel(BuildContext context) {
    if (!mounted) {
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/icons/cancel_icon.svg',
                    width: 50,
                    height: 50,
                    color: kPrimaryColor,
                  ),
                  const Text(
                    'Xác định hủy đặt phòng!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _handleCancelBookingApi();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                            ),
                            child: const Text("Đồng ý",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryLightColor,
                            ),
                            child: const Text("Đóng",
                                style: TextStyle(color: kPrimaryColor)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showPopupSuccess(BuildContext context) {
    if (!mounted) {
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            child: SingleChildScrollView(
              child: Column(
                children: const <Widget>[
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 120.0,
                    color: kPrimaryColor,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Thành công!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).then((value) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const MainScreen(selectedInit: 2)),
    ));
  }

  String getRefundPolicy(String refundPolicy) {
    switch (refundPolicy) {
      case 'BEFORE_ONE_DAY':
        return 'Hủy phòng trước một ngày';
      case 'NO_REFUND':
        return 'Không cho phép hủy phòng';
      case 'BEFORE_SEVEN_DAYS ':
        return 'Hủy phòng trước bảy ngày';
      default:
        return '';
    }
  }
}
