import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:your_tours_mobile/apis/booking_apis.dart';
import 'package:your_tours_mobile/apis/home_detail_apis.dart';
import 'package:your_tours_mobile/components/loading_overlay.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/controllers/view_comment_controller.dart';
import 'package:your_tours_mobile/models/enums/booking_status.dart';
import 'package:your_tours_mobile/models/requests/cancel_booking_request.dart';
import 'package:your_tours_mobile/models/responses/book_home_page_response.dart';
import 'package:your_tours_mobile/models/responses/home_detail_response.dart';
import 'package:your_tours_mobile/screens/history_booking_page/components/booking_evaluate.dart';
import 'package:your_tours_mobile/screens/room_detail/components/booking_info_row.dart';
import 'package:your_tours_mobile/screens/room_detail/room_detail_screen.dart';
import 'package:your_tours_mobile/size_config.dart';

class BookingDetailScreen extends StatefulWidget {
  final BookingInfo bookingDetail;

  const BookingDetailScreen({Key? key, required this.bookingDetail})
      : super(key: key);

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
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

  HandleViewCommentController handleViewCommentController =
      HandleViewCommentController();

  @override
  void initState() {
    if (widget.bookingDetail.rates != null) {
      handleViewCommentController.setView(
          widget.bookingDetail.rates!, widget.bookingDetail.comment ?? '');
    }
    super.initState();
  }

  Future<void> _handleCancelBookingApi() async {
    try {
      CancelBookingRequest request =
          CancelBookingRequest(bookingId: widget.bookingDetail.id);

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

  Future<void> callHomeDetailFromApi(String homeId) async {
    try {
      HomeDetailResponse response = await LoadingOverlay.of(context)
          .during(future: homeDetailApi(homeId));

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
            return RoomDetailScreen(
              homeDetail: response,
            );
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
                    color: kSecondaryColor,
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
                              backgroundColor: kSecondaryColor,
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
                                style: TextStyle(color: kSecondaryColor)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 30, left: 20, right: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          border: Border.all(color: kSmoke, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 1,
                            )
                          ],
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/arrow_left_direction_icon.svg',
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'My Booking',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 0),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/arrow_left_direction_icon.svg',
                        width: 16,
                        height: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 20),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Thông tin nhà',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                callHomeDetailFromApi(
                                    widget.bookingDetail.homeId ?? '');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: kSmoke, width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 2,
                                      offset: const Offset(
                                          -1, 2), // Đặt shadow theo chiều dọc
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          BookingInfoRow(
                                              title: "Tên nhà",
                                              content: widget
                                                  .bookingDetail.homeName),
                                          BookingInfoRow(
                                              title: "Chủ nhà",
                                              content:
                                                  widget.bookingDetail.owner!),
                                          BookingInfoRow(
                                              title: "Địa chỉ",
                                              content: widget.bookingDetail
                                                  .homeProvinceName!),
                                          BookingInfoRow(
                                              title: "Giá cơ bản",
                                              content:
                                                  "${NumberFormat('#,##0' ' đ').format(widget.bookingDetail.baseCost!.toInt())}/1đêm"),
                                        ],
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
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              'Thông tin khách hàng',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: kSmoke, width: 1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 2,
                                    offset: const Offset(
                                        -1, 2), // Đặt shadow theo chiều dọc
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  BookingInfoRow(
                                      title: "Khách hàng",
                                      content:
                                          widget.bookingDetail.customerName!),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Thông tin đặt nhà',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: kSmoke, width: 1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 2,
                                    offset: const Offset(
                                        -1, 2), // Đặt shadow theo chiều dọc
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      Text(
                                        'Số lượng khách',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  BookingInfoRow(
                                      title: "Người lớn:",
                                      content: widget
                                          .bookingDetail.guests![0].number
                                          .toString()),
                                  BookingInfoRow(
                                      title: "Trẻ em:",
                                      content: widget
                                          .bookingDetail.guests![2].number
                                          .toString()),
                                  BookingInfoRow(
                                      title: "Em bé:",
                                      content: widget
                                          .bookingDetail.guests![1].number
                                          .toString()),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: const [
                                      Text(
                                        'Ngày hẹn',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  BookingInfoRow(
                                      title: "Ngày nhận phòng:",
                                      content: DateFormat('dd-MM-yyyy').format(
                                          widget.bookingDetail.dateStart)),
                                  BookingInfoRow(
                                      title: "Ngày trả phòng:",
                                      content: DateFormat('dd-MM-yyyy').format(
                                          widget.bookingDetail.dateEnd)),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: const [
                                            Text(
                                              "Ngày đặt",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          widget.bookingDetail.createdDate!,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: const [
                                            Text(
                                              "Tổng tiền",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          NumberFormat('#,##0' ' đ').format(
                                              widget.bookingDetail.totalCost
                                                  .toInt()),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: const [
                                            Text(
                                              "Trạng thái",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          getDescriptionBookingStatus(
                                              widget.bookingDetail.status),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  getColorDescriptionBookingStatus(
                                                      widget.bookingDetail
                                                          .status),
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: AlignmentDirectional.bottomStart,
                          child: Text(
                            'Chính sách trả phòng',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomStart,
                          child: Text(
                            getRefundPolicy(widget.bookingDetail.refundPolicy!),
                            style: const TextStyle(
                                fontSize: 12, color: kSecondaryColor),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Phương thức thanh toán:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text('Trực tuyến',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Số tiền đã thanh toán:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      NumberFormat('#,##0' ' đ').format(widget
                                          .bookingDetail.moneyPayed!
                                          .toInt()),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kSecondaryColor))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Obx(() => (handleViewCommentController.view.value)
                            ? Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Bạn đã đánh giá',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SmoothStarRating(
                                        allowHalfRating: true,
                                        starCount: 5,
                                        rating: handleViewCommentController
                                            .rates.value,
                                        size: 24.0,
                                        color: kPrimaryColor,
                                        borderColor: kPrimaryColor,
                                        spacing: 0.0),
                                  ],
                                ),
                              )
                            : Container()),
                        Obx(() => (handleViewCommentController.view.value)
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Nhận xét: ${handleViewCommentController.comment.value}",
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            : Container()),
                        if (widget.bookingDetail.status == 'WAITING')
                          Container(
                            width: double.infinity,
                            height: 50,
                            margin: const EdgeInsets.only(
                                left: 2, right: 2, bottom: 25, top: 25),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kSecondaryColor),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                showPopupCancel(context);
                              },
                              child: const Text('Hủy đặt phòng',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
                            ),
                          ),
                        if (widget.bookingDetail.status == 'CHECK_OUT')
                          Container(
                            width: double.infinity,
                            height: 50,
                            margin: const EdgeInsets.only(
                                left: 2, right: 2, bottom: 25, top: 25),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kPrimaryColor),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25.0))),
                                    backgroundColor: Colors.white,
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => Padding(
                                          padding:
                                              MediaQuery.of(context).viewInsets,
                                          child: SizedBox(
                                              height:
                                                  SizeConfig.screenHeight / 2,
                                              child: BookingEvaluateScreen(
                                                bookingId:
                                                    widget.bookingDetail.id,
                                                handleViewCommentController:
                                                    handleViewCommentController,
                                              )),
                                        ));
                              },
                              child: const Text('Đánh giá',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
