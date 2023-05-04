import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:your_tours_mobile/apis/booking_apis.dart';
import 'package:your_tours_mobile/apis/price_home_controller.dart';
import 'package:your_tours_mobile/components/loading_overlay.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/models/enums/guest_category.dart';
import 'package:your_tours_mobile/models/requests/booking_request.dart';
import 'package:your_tours_mobile/models/responses/home_detail_response.dart';
import 'package:your_tours_mobile/models/responses/price_of_home_response.dart';
import 'package:your_tours_mobile/screens/room_detail/components/booking_page.dart';
import 'package:your_tours_mobile/screens/room_detail/components/pick_date_and_time.dart';

import 'choose_guests.dart';

class BookingBottomSheet extends StatefulWidget {
  final List<String> dateIsBooked;
  final HomeDetailResponse homeDetail;

  const BookingBottomSheet(
      {Key? key, required this.dateIsBooked, required this.homeDetail})
      : super(key: key);

  @override
  State<BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends State<BookingBottomSheet> {
  int _numOfAdult = 0;
  int _numOfChildren = 0;
  int _numOfBaby = 0;
  DateTime _startDateBooking = DateTime.now();
  DateTime _endDateBooking = DateTime.now();

  Future<void> _callCheckBookingApi() async {
    try {
      Guest adult = Guest(
          guestCategory: GuestCategoryEnum.ADULTS.name, number: _numOfAdult);
      Guest child = Guest(
          guestCategory: GuestCategoryEnum.CHILDREN.name,
          number: _numOfChildren);
      Guest baby =
          Guest(guestCategory: GuestCategoryEnum.BABY.name, number: _numOfBaby);
      List<Guest> guests = [adult, child, baby];

      BookingRequest request = BookingRequest(
          dateStart: _startDateBooking,
          dateEnd: _endDateBooking,
          homeId: widget.homeDetail.data.id,
          guests: guests);

      if (_numOfAdult == 0 && _numOfChildren == 0 && _numOfBaby == 0) {
        AnimatedSnackBar.material(
          'Nhập số lượng khách',
          type: AnimatedSnackBarType.error,
          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
          // Position of snackbar on mobile devices
          desktopSnackBarPosition: DesktopSnackBarPosition
              .topRight, // Position of snackbar on desktop devices
        ).show(context);
        return;
      }

      List<Object> response = await LoadingOverlay.of(context).during(
          future: Future.wait([
        getPriceOfHome(
            widget.homeDetail.data.id,
            DateFormat('yyyy-MM-dd').format(_startDateBooking),
            DateFormat('yyyy-MM-dd').format(_endDateBooking)),
        checkBookingApi(request),
      ]));

      PriceOfHomeResponse priceResponse = response.first as PriceOfHomeResponse;

      if (!mounted) {
        return;
      }

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BookingPage(
                    bookingRequest: request,
                    homeDetail: widget.homeDetail,
                    priceResponse: priceResponse,
                  )));
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
          padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
              const Expanded(
                child: Text(
                  'Đặt lịch',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(color: Colors.white, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 1,
                      )
                    ],
                  ),
                  child: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TableCalendar(
                          daysOfWeekHeight: 24,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          firstDay: DateTime.now(),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: DateTime.now(),
                          calendarBuilders:
                              CalendarBuilders(dowBuilder: (context, day) {
                            if (day.weekday == DateTime.sunday) {
                              final text = DateFormat.E().format(day);

                              return Center(
                                child: Text(
                                  text,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            }

                            return null;
                          }, defaultBuilder: (context, day, _) {
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(day);
                            bool flag = false;
                            for (int i = 0;
                                i < (widget.dateIsBooked.length);
                                i++) {
                              if (formattedDate == widget.dateIsBooked[i]) {
                                flag = true;
                                break;
                              }
                            }
                            if (flag) {
                              return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(80.0),
                                ),
                                child: Text(
                                  day.day.toString(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            }
                            return null;
                          }),
                          onFormatChanged: (format) {
                            CalendarFormat.month;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ChooseGuestRow(
                    title: "Người lớn",
                    description: "Từ 13 tuổi trở lên",
                    onChangeTap: (value) {
                      setState(() {
                        _numOfAdult = value;
                      });
                    },
                  ),
                  ChooseGuestRow(
                    title: "Trẻ em",
                    description: "Độ tuổi 2 - 12",
                    onChangeTap: (value) {
                      setState(() {
                        _numOfChildren = value;
                      });
                    },
                  ),
                  ChooseGuestRow(
                    title: "Em bé",
                    description: "Dưới 2 tuổi",
                    onChangeTap: (value) {
                      setState(() {
                        _numOfBaby = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0),
                        DateTimePickerRow(
                          onChangeStartDate: (value) {
                            setState(() {
                              _startDateBooking = value;
                            });
                          },
                          onChangeEndDate: (value) {
                            setState(() {
                              _endDateBooking = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _callCheckBookingApi();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kPrimaryColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text("Đặt lịch",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
