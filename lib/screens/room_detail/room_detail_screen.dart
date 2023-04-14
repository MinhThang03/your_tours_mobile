import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/controllers/booking_controller.dart';
import 'package:your_tours_mobile/controllers/price_home_controller.dart';
import 'package:your_tours_mobile/models/enums/guest_category.dart';
import 'package:your_tours_mobile/models/requests/booking_request.dart';
import 'package:your_tours_mobile/models/responses/home_detail_response.dart';
import 'package:your_tours_mobile/models/responses/price_of_home_response.dart';
import 'package:your_tours_mobile/screens/main_screen/main_screen.dart';
import 'package:your_tours_mobile/screens/room_detail/components/amenity_row.dart';
import 'package:your_tours_mobile/screens/room_detail/components/booking_page.dart';
import 'package:your_tours_mobile/screens/room_detail/components/choose_guests.dart';
import 'package:your_tours_mobile/screens/room_detail/components/pick_date_and_time.dart';

class RoomDetailScreen extends StatefulWidget {
  final int index;
  final HomeDetailResponse homeDetail;

  const RoomDetailScreen({this.index = 0, Key? key, required this.homeDetail})
      : super(key: key);

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  final myController = TextEditingController();
  final myController2 = TextEditingController();

  late PageController _pageController;
  int _currentPage = 0;

  List<AmenitiesView> _amenitiesRight = [];
  List<AmenitiesView> _amenitiesLeft = [];
  final List<String> _imagesUrl = [];

  int _numOfAdult = 0;
  int _numOfChildren = 0;
  int _numOfBaby = 0;
  DateTime _startDateBooking = DateTime.now();
  DateTime _endDateBooking = DateTime.now();

  @override
  void dispose() {
    _amenitiesRight = [];
    _amenitiesLeft = [];
    _pageController.dispose();
    myController.dispose();
    myController2.dispose();
    super.dispose();
  }

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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Nhập số lượng khách"),
          ),
        );
        return;
      }

      PriceOfHomeResponse priceResponse = await getPriceOfHome(
          widget.homeDetail.data.id,
          DateFormat('yyyy-MM-dd').format(_startDateBooking),
          DateFormat('yyyy-MM-dd').format(_endDateBooking));

      await checkBookingController(request);

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
        ),
      );
    }
  }

  void showBookingPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Đặt lịch',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _callCheckBookingApi();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                      ),
                      child: const Text("Đặt lịch",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryLightColor,
                      ),
                      child: const Text("Hủy",
                          style: TextStyle(color: kPrimaryColor)),
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

  void showAmenityPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const Text(
                      'Tiện ích',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount:
                          widget.homeDetail.data.amenitiesView?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            AmenityRow(
                              amenity:
                                  widget.homeDetail.data.amenitiesView![index],
                            ),
                            const SizedBox(
                              height: 8,
                            )
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _fetchDataHomeDetailFromApi();
  }

  Future<void> _fetchDataHomeDetailFromApi() async {
    try {
      setState(() {
        if (widget.homeDetail.data.thumbnail != null) {
          _imagesUrl.add(widget.homeDetail.data.thumbnail!);
        }

        int len = widget.homeDetail.data.imagesOfHome?.length ?? 0;
        for (int i = 0; i < len; i++) {
          _imagesUrl.add(widget.homeDetail.data.imagesOfHome![i].path);
        }

        if ((widget.homeDetail.data.amenitiesView?.length ?? 0) >= 3) {
          _amenitiesLeft = widget.homeDetail.data.amenitiesView!.sublist(0, 2);
          if ((widget.homeDetail.data.amenitiesView?.length ?? 0) >= 4) {
            _amenitiesRight =
                widget.homeDetail.data.amenitiesView!.sublist(2, 4);
          } else {
            _amenitiesRight = widget.homeDetail.data.amenitiesView!
                .sublist(2, widget.homeDetail.data.amenitiesView?.length);
          }
        } else if ((widget.homeDetail.data.amenitiesView?.length ?? 0) > 0 &&
            (widget.homeDetail.data.amenitiesView?.length ?? 0) <= 2) {
          _amenitiesLeft = widget.homeDetail.data.amenitiesView!.sublist(0, 2);
        }
      });
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Chi tiết nhà',
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Stack(children: [
                PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _pageController,
                  itemCount: _imagesUrl.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(
                      _imagesUrl[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                widget.homeDetail.data.name,
                                softWrap: true,
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Chip(
                                label: const Text('Còn phòng',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: kPrimaryColor)),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: kPrimaryColor, // Border color
                                    width: 1.0, // Border width
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ))
                          ],
                        ),
                        Text(
                          '${widget.homeDetail.data.descriptionHomeDetail} ',
                        ),
                        Text(
                          '${widget.homeDetail.data.costPerNightDefault.toString()} / 1 đêm',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/homeCard.svg',
                              width: 18,
                              height: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                                'Chủ nhà: ${widget.homeDetail.data.ownerName}'),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/location.svg',
                              width: 18,
                              height: 18,
                            ),
                            const SizedBox(width: 6),
                            SizedBox(
                              width: 300,
                              child: Text(
                                widget.homeDetail.data.provinceName ?? '',
                                softWrap: true,
                                maxLines: 3,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  const Text('Tiện ích',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      child: TextButton(
                                        onPressed: () {
                                          showAmenityPopup(context);
                                        },
                                        child: const Text('Xem thêm ...',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: _amenitiesLeft.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              AmenityRow(
                                                amenity: _amenitiesLeft[index],
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  )),
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: _amenitiesRight.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              AmenityRow(
                                                amenity: _amenitiesRight[index],
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Mô tả',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        Text(
                          widget.homeDetail.data.description ?? '',
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Lịch',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                              TableCalendar(
                                daysOfWeekHeight: 24,
                                startingDayOfWeek: StartingDayOfWeek.monday,
                                firstDay: DateTime.now(),
                                lastDay: DateTime.utc(2030, 3, 14),
                                focusedDay: DateTime.now(),
                                calendarBuilders: CalendarBuilders(
                                    dowBuilder: (context, day) {
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
                                i <
                                    (widget.homeDetail.data.dateIsBooked
                                            ?.length ??
                                        0);
                                i++) {
                              if (formattedDate ==
                                  widget.homeDetail.data.dateIsBooked![i]) {
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
                          height: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            showRatingPopup(context);
                          },
                          child: Container(
                            height: 60,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text('Đánh giá',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                                RatingBar(
                                  itemSize: 25,
                                  maxRating: 5.0,
                                  minRating: 0.0,
                                  initialRating: 5,
                                  onRatingUpdate: (double rating) => {},
                                  ignoreGestures: true,
                                  allowHalfRating: true,
                                  ratingWidget: RatingWidget(
                                    empty: const Icon(
                                      Icons.star_border_rounded,
                                      color: kPrimaryColor,
                                    ),
                              full: const Icon(
                                Icons.star_rounded,
                                color: kPrimaryColor,
                              ),
                              half: const Icon(
                                Icons.star_half_rounded,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          const Text(
                            '5 /5',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                        ],
                            ),
                          ),
                        ),

                        const Text('Gợi ý cho bạn',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        // SizedBox(
                        //         height: 310,
                        //         child: ListView.builder(
                        //           scrollDirection: Axis.horizontal,
                        //           itemBuilder: (context, index) {
                        //             return  NearByRoomCard(
                        //               indexRoom: index,
                        //               title: RoomList.rooms[index].title,
                        //               imagePath: RoomList.rooms[index].imagePath.first,
                        //               rating: RoomList.rooms[index].rating,
                        //               price: RoomList.rooms[index].price,
                        //               area: RoomList.rooms[index].area,
                        //               address: RoomList.rooms[index].address,
                        //               isFavorite: RoomList.rooms[index].isFavorite,);
                        //           },
                        //           itemCount: RoomList.rooms.length,
                        //         ),
                        //       ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            showBookingPopup(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryLightColor,
          ),
          child: const Text("Đặt lịch", style: TextStyle(color: kPrimaryColor)),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < (_imagesUrl.length); i++) {
      indicators.add(
        i == _currentPage
            ? _buildPageIndicatorItem(true)
            : _buildPageIndicatorItem(false),
      );
    }
    return indicators;
  }

  Widget _buildPageIndicatorItem(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

void showRatingPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Các tiêu chí đánh giá của yourtours',
            style: TextStyle(fontSize: 15)),
        content: SizedBox(
          width: 500,
          height: 130,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Vị trí địa lý', style: TextStyle(fontSize: 13)),
                  RatingBar(
                    itemSize: 24,
                    maxRating: 5.0,
                    minRating: 0.0,
                    initialRating: 4.5,
                    onRatingUpdate: (double rating) => {},
                    ignoreGestures: true,
                    allowHalfRating: true,
                    ratingWidget: RatingWidget(
                      empty: const Icon(
                        Icons.star_border_rounded,
                        color: kPrimaryColor,
                      ),
                      full: const Icon(
                        Icons.star_rounded,
                        color: kPrimaryColor,
                      ),
                      half: const Icon(
                        Icons.star_half_rounded,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Cơ sở vật chất', style: TextStyle(fontSize: 13)),
                  RatingBar(
                    itemSize: 24,
                    maxRating: 5.0,
                    minRating: 0.0,
                    initialRating: 3.5,
                    onRatingUpdate: (double rating) => {},
                    ignoreGestures: true,
                    allowHalfRating: true,
                    ratingWidget: RatingWidget(
                      empty: const Icon(
                        Icons.star_border_rounded,
                        color: kPrimaryColor,
                      ),
                      full: const Icon(
                        Icons.star_rounded,
                        color: kPrimaryColor,
                      ),
                      half: const Icon(
                        Icons.star_half_rounded,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('An ninh', style: TextStyle(fontSize: 13)),
                  RatingBar(
                    itemSize: 24,
                    maxRating: 5.0,
                    minRating: 0.0,
                    initialRating: 5,
                    onRatingUpdate: (double rating) => {},
                    ignoreGestures: true,
                    allowHalfRating: true,
                    ratingWidget: RatingWidget(
                      empty: const Icon(
                        Icons.star_border_rounded,
                        color: kPrimaryColor,
                      ),
                      full: const Icon(
                        Icons.star_rounded,
                        color: kPrimaryColor,
                      ),
                      half: const Icon(
                        Icons.star_half_rounded,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Tất cả các phòng khi đăng trên ứng dụng đã được yourtours_app kiểm định dựa trên những tiêu chí ở trên.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
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
            builder: (context) => const MainScreen(selectedInit: 0)),
      ));
}
