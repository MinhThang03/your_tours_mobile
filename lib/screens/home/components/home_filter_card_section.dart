import 'dart:developer';

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
import 'package:your_tours_mobile/controllers/home_select_filter_controller.dart';
import 'package:your_tours_mobile/models/responses/home_detail_response.dart';
import 'package:your_tours_mobile/models/responses/home_page_response.dart';
import 'package:your_tours_mobile/screens/room_detail/room_detail_screen.dart';
import 'package:your_tours_mobile/services/handle_province_name.dart';

class HomeFilterCardList extends StatefulWidget {
  final String topic;

  const HomeFilterCardList({Key? key, required this.topic}) : super(key: key);

  @override
  State<HomeFilterCardList> createState() => _HomeFilterCardListState();
}

class _HomeFilterCardListState extends State<HomeFilterCardList> {
  HomeSelectFilterController homeSelectFilterController =
  Get.find<HomeSelectFilterController>();


  Future<HomePageResponse?> _fetchDataListHomeApi(String topic) async {
    try {
      HomePageResponse response = await homePageApi(topic);
      return response;
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
    return LoadApiWidget<HomePageResponse?>(
        autoRefresh: true,
        successBuilder: (context, response) {
          return successWidget(context, response!);
        },
        loadingBuilder: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
                8,
                (index) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: ShimmerLoading(
                    width: 186,
                    height: 156,
                    boxShape: BoxShape.rectangle,
                  ),
                )),
          ),
        ),
        fetchDataFunction: _fetchDataListHomeApi(widget.topic));
  }

  Widget successWidget(BuildContext context, HomePageResponse response) {
    log(name: 'RESPONSE:', response.toJson().toString());

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          response.data.content.length,
          (index) => GestureDetector(
            onTap: () {},
                child: Row(
                  children: [
                    HomeFilterCard(
                      homeInfo: response.data.content[index],
                    ),
                    const SizedBox(
                      width: 16,
                    )
                  ],
                ),
          ),
        ),
      ),
    );
  }
}

class HomeFilterCard extends StatefulWidget {
  final MobileHomeInfo homeInfo;

  const HomeFilterCard({super.key, required this.homeInfo});

  @override
  State<HomeFilterCard> createState() => _HomeFilterCardState();
}

class _HomeFilterCardState extends State<HomeFilterCard> {
  late HandleFavouriteController favoriteController =
      HandleFavouriteController(widget.homeInfo.isFavorite.obs);

  String _handleNameHome(String? name) {
    if (name == null) {
      return '';
    }

    if (name.length <= 11) {
      return name;
    }

    return '${name.substring(0, 8)}...';
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
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          callHomeDetailFromApi(widget.homeInfo.id);
        },
        child: Container(
          height: 236,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  blurRadius: 2,
                  offset: const Offset(0, 1)),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(12.0)),
                      child: Image.network(
                        widget.homeInfo.thumbnail,
                        fit: BoxFit.cover,
                        height: 156,
                        width: 186,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.circular(12))),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(
                                Icons.star_purple500_outlined,
                                size: 18,
                                color: Colors.orange,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                "5.0",
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      )),
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
                            mobileSnackBarPosition:
                                MobileSnackBarPosition.bottom,
                            desktopSnackBarPosition:
                                DesktopSnackBarPosition.topRight,
                          ).show(context);
                        } else {
                          AnimatedSnackBar.material(
                            favoriteController.errorMessage.value,
                            type: AnimatedSnackBarType.error,
                            mobileSnackBarPosition:
                                MobileSnackBarPosition.bottom,
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
                ]),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _handleNameHome(widget.homeInfo.name),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/location_fill_icon.svg',
                                width: 18,
                                height: 18,
                                color: const Color(0xFFFC674E),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                _handleNameHome(getShortProvinceName(
                                    widget.homeInfo.provinceName)),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        NumberFormat('#,##0' ' đ').format(
                            widget.homeInfo.costPerNightDefault.toInt()),
                        style: const TextStyle(color: kSecondary),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
