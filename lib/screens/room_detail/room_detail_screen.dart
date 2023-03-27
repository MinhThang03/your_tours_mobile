import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/controllers/home_detail_controller.dart';
import 'package:your_tours_mobile/models/Room.dart';
import 'package:your_tours_mobile/models/responses/home_detail_response.dart';
import 'package:your_tours_mobile/screens/main_screen/main_screen.dart';
import 'package:your_tours_mobile/screens/room_detail/components/booking_page.dart';
import 'package:your_tours_mobile/screens/room_detail/components/choose_guests.dart';
import 'package:your_tours_mobile/screens/room_detail/components/pick_date_and_time.dart';

class RoomDetailScreen extends StatefulWidget {
  final int index;
  final String homeId;

  const RoomDetailScreen({this.index = 0, Key? key, required this.homeId})
      : super(key: key);

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  final myController = TextEditingController();
  final myController2 = TextEditingController();

  late RoomTest _room;
  HomeDetailResponse? _homeDetail;
  late PageController _pageController;
  int _currentPage = 0;

  int _numOfAdult = 0;
  int _numOfChildren = 0;
  int _numOfBaby = 0;

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
                      children: const [
                        SizedBox(height: 10.0),
                        DateTimePickerRow()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookingPage()));
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

  @override
  void initState() {
    super.initState();
    _room = RoomList.rooms[widget.index];
    _pageController = PageController(initialPage: _currentPage);
    _fetchDataHomeDetailFromApi();
  }

  Future<void> _fetchDataHomeDetailFromApi() async {
    try {
      final response = await homeDetailController(widget.homeId);
      setState(() {
        _homeDetail = response;
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
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
          'Chi tiết phòng',
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: _homeDetail == null
            ? null
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Stack(children: [
                      PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: _pageController,
                        itemCount: _homeDetail?.data.imagesOfHome?.length,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            _homeDetail!.data.imagesOfHome![index].path,
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
                                      _homeDetail!.data.name,
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
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ))
                                ],
                              ),
                              Text(
                                '${_homeDetail?.data.descriptionHomeDetail} ',
                              ),
                              Text(
                                '${_homeDetail?.data.costPerNightDefault.toString()} / 1 đêm',
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
                                      'Chủ nhà: ${_homeDetail?.data.ownerName}'),
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
                                      _homeDetail?.data.provinceName ?? '',
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
                              const Text('Mô tả',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              Text(
                                _homeDetail?.data.description ?? '',
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
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
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                    );
                                  }

                                  return null;
                                }, defaultBuilder: (context, day, _) {
                                  String formattedDate =
                                      DateFormat('dd/MM/yyyy').format(day);
                                  bool flag = false;
                                  for (int i = 0;
                                      i <
                                          (_homeDetail
                                                  ?.data.dateIsBooked?.length ??
                                              0);
                                      i++) {
                                    if (formattedDate ==
                                        _homeDetail?.data.dateIsBooked![i]) {
                                      flag = true;
                                      break;
                                    }
                                  }
                                  if (flag) {
                                    return Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(80.0),
                                      ),
                                      child: Text(
                                        day.day.toString(),
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    );
                                  }
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
                                  initialRating: _room.rating,
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
                          Text(
                            '${_room.rating} /5',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
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
    for (int i = 0; i < _room.imagePath.length; i++) {
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
