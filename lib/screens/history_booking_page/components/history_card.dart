import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:your_tours_mobile/apis/booking_controller.dart';
import 'package:your_tours_mobile/models/enums/booking_status.dart';
import 'package:your_tours_mobile/models/requests/cancel_booking_request.dart';
import 'package:your_tours_mobile/models/responses/book_home_page_response.dart';
import 'package:your_tours_mobile/screens/main_screen/main_screen.dart';

import '../../../components/loading_overlay.dart';
import '../../../constants.dart';
import 'booking_info_row.dart';

class HistoryCard extends StatefulWidget {
  final BookingInfo bookingInfo;

  const HistoryCard({Key? key, required this.bookingInfo}) : super(key: key);

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  void initState() {
    super.initState();
  }

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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16, top: 8),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 8.0, top: 20, right: 10),
                    child: Stack(children: [
                      ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(4.0)),
                        child: Image.network(
                          widget.bookingInfo.thumbnail,
                          fit: BoxFit.cover,
                          height: 136,
                          width: 128,
                        ),
                      ),
                    ]),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.bookingInfo.homeName,
                            style:
                            const TextStyle(fontWeight: FontWeight.w600)),
                        BookingCardInfoRow(
                          icon: 'assets/icons/price.svg',
                          title: 'Số tiền:',
                          content: '${widget.bookingInfo.cost.toString()}đ',
                        ),
                        BookingCardInfoRow(
                          icon: 'assets/icons/check_in.svg',
                          title: 'Ngày đến:',
                          content: DateFormat('dd-MM-yyyy')
                              .format(widget.bookingInfo.dateStart),
                        ),
                        BookingCardInfoRow(
                          icon: 'assets/icons/check_out.svg',
                          title: 'Ngày đi:',
                          content: DateFormat('dd-MM-yyyy')
                              .format(widget.bookingInfo.dateEnd),
                        ),
                        BookingCardInfoRow(
                          icon: 'assets/icons/status_lock.svg',
                          title: 'Tình trạng:',
                          content: getDescriptionBookingStatus(
                              widget.bookingInfo.status),
                        ),
                        Text(getRefundPolicy(widget.bookingInfo.refundPolicy),
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                            )),
                        widget.bookingInfo.status != 'WAITING'
                            ? Container()
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                showPopupCancel(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                              ),
                              child: const Text('Hủy đặt'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
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
