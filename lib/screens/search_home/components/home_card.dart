import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:your_tours_mobile/apis/favourite_apis.dart';
import 'package:your_tours_mobile/apis/home_detail_apis.dart';
import 'package:your_tours_mobile/components/loading_overlay.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/models/requests/favourite_request.dart';
import 'package:your_tours_mobile/models/responses/home_detail_response.dart';
import 'package:your_tours_mobile/models/responses/home_info_response.dart';
import 'package:your_tours_mobile/screens/room_detail/room_detail_screen.dart';

import '../../../components/rating_bar.dart';

class HomeCard extends StatefulWidget {
  final int index;
  final HomeInfo homeInfo;

  const HomeCard({Key? key, this.index = 0, required this.homeInfo})
      : super(key: key);

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  bool _isFavourited = false;
  late PageController _pageController;

  int _currentPage = 0;

  Future<void> _handleFavourite() async {
    try {
      await favouriteHandlerApi(FavouriteRequest(homeId: widget.homeInfo.id));

      setState(() {
        _isFavourited = !_isFavourited;
      });

      if (!mounted) return;

      if (_isFavourited == true) {
        AnimatedSnackBar.material(
          "Thêm vào danh sách yêu thích thành công",
          type: AnimatedSnackBarType.success,
          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
          // Position of snackbar on mobile devices
          desktopSnackBarPosition: DesktopSnackBarPosition
              .topRight, // Position of snackbar on desktop devices
        ).show(context);
      } else {
        AnimatedSnackBar.material(
          "Xóa khỏi danh sách yêu thích thành công",
          type: AnimatedSnackBarType.success,
          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
          desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
        ).show(context);
      }
    } on FormatException catch (error) {
      AnimatedSnackBar.material(
        error.message,
        type: AnimatedSnackBarType.error,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      ).show(context);
    }
  }

  Future<void> _callHomeDetailFromApi() async {
    try {
      HomeDetailResponse response = await LoadingOverlay.of(context)
          .during(future: homeDetailApi(widget.homeInfo.id));

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

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage, keepPage: true);
    _isFavourited = widget.homeInfo.isFavorite ?? false;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {_callHomeDetailFromApi()},
      child: Container(
        margin: const EdgeInsetsDirectional.only(
            start: 16.0, end: 16.0, top: 8, bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 360,
                child: Stack(children: [
                  PageView.builder(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: widget.homeInfo.imagesOfHome?.length ?? 0,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                        child: Image.network(
                          widget.homeInfo.imagesOfHome![index].path,
                          fit: BoxFit.cover,
                          height: 340,
                          width: 366,
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 0.5,
                    right: 0.5,
                    child: IconButton(
                      icon: _isFavourited
                          ? SvgPicture.asset(
                              'assets/icons/Heart Icon_2.svg',
                              width: 20,
                              height: 20,
                              color: kPrimaryColor,
                            )
                          : SvgPicture.asset(
                              'assets/icons/Heart Icon.svg',
                              width: 20,
                              height: 20,
                              color: Colors.red,
                            ),
                      onPressed: () {
                        _handleFavourite();
                      },
                    ),
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
              const SizedBox(
                height: 12,
              ),
              Text(widget.homeInfo.name!,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                  )),
              const SizedBox(
                height: 2,
              ),
              const RatingBarCommon(
                maxRating: 5,
                minRating: 0,
                initialRating: 5,
              ),
              // Row(
              //   children: [
              //     SvgPicture.asset(
              //       'assets/icons/homeCard.svg',
              //       width: 20,
              //       height: 20,
              //       color: Colors.red,
              //     ),
              //     SizedBox(width: 5),
              //     Text(
              //       '50 m2',
              //       style: TextStyle(color: Colors.black),
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/location.svg',
                    width: 20,
                    height: 20,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.homeInfo.provinceName ?? '',
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Text(
                  '${widget.homeInfo.costPerNightDefault?.toInt().toString()} VNĐ',
                  style: const TextStyle(
                      fontSize: 16,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < widget.homeInfo.imagesOfHome!.length; i++) {
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
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8.0,
      width: isActive ? 8.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}
