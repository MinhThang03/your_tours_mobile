import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/apis/home_page_filter_api.dart';
import 'package:your_tours_mobile/components/loading_api_widget.dart';
import 'package:your_tours_mobile/components/shimmer_loading.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/controllers/favourite_controller.dart';
import 'package:your_tours_mobile/controllers/home_select_filter_controller.dart';
import 'package:your_tours_mobile/models/responses/home_info_response.dart';
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


  Future<GetHomePageResponse?> _fetchDataListHomeApi(String topic) async {
    try {
      print("TOPIC:    " + topic);
      GetHomePageResponse response = await homePageApi(topic);
      log(name: 'RESPONSE 111:', response.toJson().toString());
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
    return LoadApiWidget<GetHomePageResponse?>(
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

  Widget successWidget(BuildContext context, GetHomePageResponse response) {
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

class HomeFilterCard extends StatelessWidget {
  final HomeInfo homeInfo;

  late HandleFavouriteController favoriteController =
  HandleFavouriteController((homeInfo.isFavorite ?? false).obs);

  HomeFilterCard({super.key, required this.homeInfo});

  String _handleNameHome(String? name) {
    if (name == null) {
      return '';
    }

    if (name.length <= 11) {
      return name;
    }

    return '${name.substring(0, 8)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {},
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
                        homeInfo.thumbnail ??
                            "https://pearlriverhotel.vn/wp-content/uploads/2019/07/pearl-river-hotel-home1.jpg",
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
                      onTap: () {
                        favoriteController.handleFavorite(context);
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
                            _handleNameHome(homeInfo.name),
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
                                    homeInfo.provinceName)),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            '80đ',
                            style: TextStyle(color: kSecondary),
                          ),
                          Text('/Night'),
                        ],
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
