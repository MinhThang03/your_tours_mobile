import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/controllers/favourite_controller.dart';
import 'package:your_tours_mobile/models/responses/home_detail_response.dart';
import 'package:your_tours_mobile/screens/main_screen/main_screen.dart';
import 'package:your_tours_mobile/size_config.dart';

import 'components/amenity_bottom_sheet.dart';
import 'components/amenity_card.dart';
import 'components/booking_bottom_sheet.dart';
import 'components/comment_bottom_sheet.dart';
import 'components/comment_section.dart';

class RoomDetailScreen extends StatefulWidget {
  final int index;
  final HomeDetailResponse homeDetail;

  const RoomDetailScreen({this.index = 0, Key? key, required this.homeDetail})
      : super(key: key);

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<String> _imagesUrl = [];
  late HandleFavouriteController favoriteController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    favoriteController = HandleFavouriteController(
        (widget.homeDetail.data.isFavorite ?? false).obs);
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
      });
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
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
                              return ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                                child: Image.network(
                                  _imagesUrl[index],
                                  fit: BoxFit.cover,
                                ),
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
                          ),
                          Positioned(
                            top: 0,
                            left: 12,
                            right: 12,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8.0)),
                                      color: Colors.white.withOpacity(0.4),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/arrow_left_direction_icon.svg',
                                      width: 16,
                                      height: 16,
                                      color: kWhite,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: Text(
                                    'Details',
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(color: kWhite, fontSize: 25),
                                  ),
                                ),
                                Obx(() => GestureDetector(
                                      onTap: () async {
                                        await favoriteController.handleFavorite(
                                            context, widget.homeDetail.data.id);

                                        if (!mounted) return;

                                        if (favoriteController.message.value !=
                                            '') {
                                          AnimatedSnackBar.material(
                                            favoriteController.message.value,
                                            type: AnimatedSnackBarType.success,
                                            mobileSnackBarPosition:
                                                MobileSnackBarPosition.bottom,
                                            desktopSnackBarPosition:
                                                DesktopSnackBarPosition
                                                    .topRight,
                                          ).show(context);
                                        } else {
                                          AnimatedSnackBar.material(
                                            favoriteController
                                                .errorMessage.value,
                                            type: AnimatedSnackBarType.error,
                                            mobileSnackBarPosition:
                                                MobileSnackBarPosition.bottom,
                                            desktopSnackBarPosition:
                                                DesktopSnackBarPosition
                                                    .topRight,
                                          ).show(context);
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8.0)),
                                          color: Colors.white.withOpacity(0.4),
                                        ),
                                        child:
                                            favoriteController.isFavorite.value
                                                ? SvgPicture.asset(
                                                    'assets/icons/Heart Icon_2.svg',
                                                    width: 16,
                                                    height: 16,
                                                    color: kSecondaryColor,
                                                  )
                                                : SvgPicture.asset(
                                                    'assets/icons/Heart Icon.svg',
                                                    width: 16,
                                                    height: 16,
                                                    color: kWhite,
                                                  ),
                                      ),
                                    )),
                              ],
                            ),
                          )
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.homeDetail.data.name,
                                          softWrap: true,
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/Star Icon.svg',
                                            width: 18,
                                            height: 18,
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "5.0",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${widget.homeDetail.data.descriptionHomeDetail} ',
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          widget.homeDetail.data.provinceName ??
                                              '',
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
                                              // showAmenityPopup(context);
                                              showModalBottomSheet(
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      25.0))),
                                                  backgroundColor: Colors.white,
                                                  context: context,
                                                  isScrollControlled: true,
                                                  builder: (context) => Padding(
                                                        padding: MediaQuery.of(
                                                                context)
                                                            .viewInsets,
                                                        child: SizedBox(
                                                            height: SizeConfig
                                                                    .screenHeight *
                                                                (2 / 3),
                                                            child:
                                                                AmenityBottomSheet(
                                                              amenitiesViews: widget
                                                                      .homeDetail
                                                                      .data
                                                                      .amenitiesView ??
                                                                  [],
                                                            )),
                                                      ));
                                            },
                                            child: const Text('Chi tiết ...',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                        widget.homeDetail.data.amenitiesView
                                                ?.length ??
                                            0,
                                        (index) => Row(
                                          children: [
                                            AmenityCard(
                                              amenitiesView: widget.homeDetail
                                                  .data.amenitiesView![index],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  Text(
                                    widget.homeDetail.data.description ?? '',
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Text('Đánh giá',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    child: TextButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            25.0))),
                                            backgroundColor: Colors.white,
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (context) => SizedBox(
                                                height:
                                                    SizeConfig.screenHeight *
                                                        4 /
                                                        5,
                                                child: CommentBottomSheet(
                                                  homeId:
                                                      widget.homeDetail.data.id,
                                                )));
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
                            CommentSection(homeId: widget.homeDetail.data.id),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        height: 100,
        color: const Color(0xffE8EEF1),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                      NumberFormat('#,##0' ' VNĐ').format(
                          widget.homeDetail.data.costPerNightDefault!.toInt()),
                      style: const TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  const Text("Per Night",
                      style: TextStyle(
                        color: kTextColor,
                      )),
                ],
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0))),
                      backgroundColor: Colors.white,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: SizedBox(
                                height: SizeConfig.screenHeight * (5 / 6),
                                child: BookingBottomSheet(
                                  dateIsBooked:
                                      widget.homeDetail.data.dateIsBooked ?? [],
                                  homeDetail: widget.homeDetail,
                                )),
                          ));
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    kPrimaryColor,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Book Now",
                      style: TextStyle(color: kWhite)),
                ),
              ),
            ),
          ],
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
