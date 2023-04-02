import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/controllers/booking_controller.dart';
import 'package:your_tours_mobile/models/requests/booking_request.dart';
import 'package:your_tours_mobile/models/responses/home_detail_response.dart';
import 'package:your_tours_mobile/models/responses/price_of_home_response.dart';
import 'package:your_tours_mobile/screens/room_detail/components/booking_info_row.dart';
import 'package:your_tours_mobile/screens/room_detail/components/price_of_home_row.dart';

import '../../main_screen/main_screen.dart';

class BookingPage extends StatefulWidget {
  final BookingRequest bookingRequest;
  final HomeDetailResponse homeDetail;
  final PriceOfHomeResponse priceResponse;

  const BookingPage(
      {Key? key,
      required this.bookingRequest,
      required this.homeDetail,
      required this.priceResponse})
      : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  Future<void> _callCreateBookingApi() async {
    try {
      double cost = widget.priceResponse.data.percent == null
          ? widget.priceResponse.data.totalCostWithSurcharge
          : widget.priceResponse.data.totalCostWithSurcharge *
              (widget.priceResponse.data.percent! / 100);

      widget.bookingRequest.moneyPayed = cost;
      widget.bookingRequest.paymentMethod = 'PAY_IN_FULL';

      await createBookingController(widget.bookingRequest);

      if (!mounted) {
        return;
      }
      showPopupSuccess(context);
    } on FormatException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Thanh toán',
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Thông tin khách hàng',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Số lượng khách',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    BookingInfoRow(
                        title: "Người lớn:",
                        content:
                            widget.bookingRequest.guests[0].number.toString()),
                    BookingInfoRow(
                        title: "Trẻ em:",
                        content:
                            widget.bookingRequest.guests[1].number.toString()),
                    BookingInfoRow(
                        title: "Em bé:",
                        content:
                            widget.bookingRequest.guests[2].number.toString()),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Ngày hẹn',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    BookingInfoRow(
                        title: "Ngày nhận phòng:",
                        content: DateFormat('dd-MM-yyyy')
                            .format(widget.bookingRequest.dateStart)),
                    BookingInfoRow(
                        title: "Ngày trả phòng:",
                        content: DateFormat('dd-MM-yyyy')
                            .format(widget.bookingRequest.dateEnd)),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
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
                    const Text(
                      'Thông tin nhà',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BookingInfoRow(
                        title: "Tên nhà", content: widget.homeDetail.data.name),
                    BookingInfoRow(
                        title: "Chủ nhà",
                        content: widget.homeDetail.data.ownerName!),
                    BookingInfoRow(
                        title: "Địa chỉ",
                        content: widget.homeDetail.data.provinceName!),
                    BookingInfoRow(
                        title: "Giá cơ bản",
                        content:
                            "${widget.homeDetail.data.costPerNightDefault?.toInt()}đ /1đêm"),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
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
                    const Text(
                      'Thông tin thanh toán',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: const [
                          Text(
                            'Chi tiết giá',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.priceResponse.data.detail.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PriceOfHomeRow(
                          title: DateFormat("dd-MM-yyyy").format(
                              widget.priceResponse.data.detail[index].day),
                          content:
                              "${widget.priceResponse.data.detail[index].cost.toInt()}đ",
                          especially: widget
                              .priceResponse.data.detail[index].especially,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: const [
                          Text(
                            'Phụ phí',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.homeDetail.data.surcharges?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return BookingInfoRow(
                          title: widget.homeDetail.data.surcharges![index]
                              .surchargeCategoryName,
                          content:
                              "${widget.homeDetail.data.surcharges![index].cost.toInt()}đ",
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 0, top: 0),
                      child: Column(
                        children: [
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
                                  "${widget.priceResponse.data.totalCostWithSurcharge.toInt()}đ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    widget.priceResponse.data.discountName == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: const [
                                Text(
                                  'Khuyến mãi',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    widget.priceResponse.data.discountName == null
                        ? Container()
                        : BookingInfoRow(
                            title: widget.priceResponse.data.discountName!,
                            content: "${widget.priceResponse.data.percent!}%"),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 0, top: 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: const [
                                    Text(
                                      "Cần thanh toán",
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
                                  widget.priceResponse.data.percent == null
                                      ? "${widget.priceResponse.data.totalCostWithSurcharge}đ"
                                      : "${widget.priceResponse.data.totalCostWithSurcharge * (widget.priceResponse.data.percent! / 100)}đ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Chi tiết giá",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/location.svg',
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            flex: 3,
                            child: Text(
                              widget.homeDetail.data.provinceName!,
                              style: const TextStyle(color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Padding(
                  padding: EdgeInsets.only(left: 11.0, bottom: 6, top: 25.0),
                  child: Text(
                    'Thanh toán',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Padding(
                  padding: EdgeInsets.only(left: 12.0, bottom: 16),
                  child: Text(
                    'Chọn phương thức thanh toán và mã khuyến mãi',
                    style: TextStyle(fontSize: 12),
                  ),
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
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Phương thức thanh toán:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Trực tuyến',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Số tiền:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                              widget.priceResponse.data.percent == null
                                  ? "${widget.priceResponse.data.totalCostWithSurcharge}đ"
                                  : "${widget.priceResponse.data.totalCostWithSurcharge * (widget.priceResponse.data.percent! / 100)}đ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(
                    left: 2, right: 2, bottom: 25, top: 25),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kPrimaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    _callCreateBookingApi();
                  },
                  child: const Text('Thanh toán',
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
    );
  }
}

void showPopupSuccess(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: 288.0,
          width: 390.0,
          child: Column(
            children: const <Widget>[
              SizedBox(
                height: 50,
              ),
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
      );
    },
  ).then((value) => Navigator.push(
    context,
        MaterialPageRoute(
            builder: (context) => const MainScreen(selectedInit: 2)),
      ));
}
