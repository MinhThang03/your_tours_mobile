import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:your_tours_mobile/apis/booking_controller.dart';
import 'package:your_tours_mobile/models/responses/book_home_page_response.dart';
import 'package:your_tours_mobile/screens/history_booking_page/components/booking_detail_screen.dart';
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
  Future<void> callPageDetail() async {
    try {
      GetBookHomeDetailResponse response = await LoadingOverlay.of(context)
          .during(future: getBookingDetailApi(widget.bookingInfo.id));

      if (!mounted) {
        return;
      }

      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: timeNavigatorPush,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return BookingDetailScreen(bookingDetail: response.data);
          },
        ),
      );
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
    return GestureDetector(
      onTap: () {
        callPageDetail();
      },
      child: Container(
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
                widget.bookingInfo.thumbnail ??
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKsta_M2aSQ94Gm2Vo9Q5uf0qoiVfjR5Ai19PFsQA_X6K9TdpmLaQecEzd-aBa7gzi8Wg&usqp=CAU",
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
      ),
    );
  }
}
