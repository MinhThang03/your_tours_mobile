import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:your_tours_mobile/apis/home_detail_apis.dart';
import 'package:your_tours_mobile/apis/home_page_filter_api.dart';
import 'package:your_tours_mobile/components/loading_api_widget.dart';
import 'package:your_tours_mobile/components/loading_overlay.dart';
import 'package:your_tours_mobile/components/shimmer_loading.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/controllers/favourite_controller.dart';
import 'package:your_tours_mobile/models/responses/home_detail_response.dart';
import 'package:your_tours_mobile/models/responses/home_info_response.dart';
import 'package:your_tours_mobile/screens/room_detail/room_detail_screen.dart';
import 'package:your_tours_mobile/services/handle_province_name.dart';
import 'package:your_tours_mobile/size_config.dart';

class HomeRecommendCardList extends StatefulWidget {
  final String? city;

  const HomeRecommendCardList({Key? key, this.city}) : super(key: key);

  @override
  State<HomeRecommendCardList> createState() => _HomeRecommendCardListState();
}

class _HomeRecommendCardListState extends State<HomeRecommendCardList> {
  Future<GetHomePageResponse?> _fetchDataListHomeRecommendApi() async {
    try {
      return await homeRecommendApi(widget.city);
    } on FormatException catch (error) {
      AnimatedSnackBar.material(
        error.message,
        type: AnimatedSnackBarType.error,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      ).show(context);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return LoadApiWidget<GetHomePageResponse?>(
        autoRefresh: true,
        successBuilder: (context, response) {
          return successWidget(context, response!);
        },
        loadingBuilder: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: List.generate(
                10,
                (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ShimmerLoading(
                        width: SizeConfig.screenWidth,
                        height: 200,
                        boxShape: BoxShape.rectangle,
                      ),
                    )),
          ),
        ),
        fetchDataFunction: _fetchDataListHomeRecommendApi());
  }

  Widget successWidget(BuildContext context, GetHomePageResponse response) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: response.data.content.length,
      itemBuilder: (context, index) {
        return HomeRecommendCard(
          homeInfo: response.data.content[index],
        );
      },
    );
  }
}

class HomeRecommendCard extends StatefulWidget {
  final int index;
  final HomeInfo homeInfo;

  const HomeRecommendCard({Key? key, this.index = 0, required this.homeInfo})
      : super(key: key);

  @override
  State<HomeRecommendCard> createState() => _HomeRecommendCardState();
}

class _HomeRecommendCardState extends State<HomeRecommendCard> {
  late HandleFavouriteController favoriteController;

  late PageController _pageController;

  int _currentPage = 0;

  @override
  void initState() {
    favoriteController =
        HandleFavouriteController((widget.homeInfo.isFavorite ?? false).obs);
    _pageController = PageController(initialPage: _currentPage, keepPage: true);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {callHomeDetailFromApi(widget.homeInfo.id)},
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: kWhite,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(2, 8)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: PageView.builder(
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
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18.0),
                            topRight: Radius.circular(18.0)),
                        child: Image.network(
                          widget.homeInfo.imagesOfHome![index].path,
                          fit: BoxFit.cover,
                          height: 132,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 12,
                  child: GestureDetector(
                    onTap: () async {
                      await favoriteController.handleFavorite(
                          context, widget.homeInfo.id);

                      if (!mounted) return;

                      if (favoriteController.message.value != '') {
                        AnimatedSnackBar.material(
                          favoriteController.message.value,
                          type: AnimatedSnackBarType.success,
                          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                          desktopSnackBarPosition:
                              DesktopSnackBarPosition.topRight,
                        ).show(context);
                      } else {
                        AnimatedSnackBar.material(
                          favoriteController.errorMessage.value,
                          type: AnimatedSnackBarType.error,
                          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                          desktopSnackBarPosition:
                              DesktopSnackBarPosition.topRight,
                        ).show(context);
                      }
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                blurRadius: 3,
                                offset: const Offset(0, 3)),
                          ],
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Obx(
                                  () => favoriteController.isFavorite.value
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
                                      color: Colors.red,
                              ),
                            ))),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.homeInfo.name ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        letterSpacing: 0,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/location_fill_icon.svg',
                              width: 20,
                              height: 20,
                              color: kSecondary,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              getShortProvinceName(
                                  widget.homeInfo.provinceName),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/Star Icon.svg',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "5.0",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                      '${NumberFormat('#,##0' ' đ').format(widget.homeInfo.costPerNightDefault!.toInt())} /Night',
                      style: const TextStyle(
                          fontSize: 18,
                          letterSpacing: 0,
                          color: kTextColor,
                          fontWeight: FontWeight.w900)),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < (widget.homeInfo.imagesOfHome?.length ?? 0); i++) {
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
