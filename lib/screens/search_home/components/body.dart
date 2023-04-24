import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:your_tours_mobile/apis/home_page_filter_api.dart';
import 'package:your_tours_mobile/components/loading_api_widget.dart';
import 'package:your_tours_mobile/components/shimmer_loading.dart';
import 'package:your_tours_mobile/models/responses/home_info_response.dart';

import 'home_search_card.dart';

class Body extends StatefulWidget {
  final String keyword;
  final String amenityId;

  const Body({Key? key, required this.keyword, required this.amenityId})
      : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<GetHomePageResponse?> _fetchDataHomesFromApi() async {
    try {
      String? amenityId = widget.amenityId == '' ? null : widget.amenityId;
      String? keyword = widget.keyword == '' ? null : widget.keyword;

      return await homePageFilterApi(amenityId, keyword);
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
          child: Column(
            children: List.generate(
                5,
                (index) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: ShimmerLoadingFavorite(
                        width: 120,
                        height: 120,
                        boxShape: BoxShape.rectangle,
                      ),
                    )),
          ),
        ),
        fetchDataFunction: _fetchDataHomesFromApi());
  }

  Widget successWidget(BuildContext context, GetHomePageResponse response) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: response.data.content.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              HomeSearchCard(
                homeInfo: response.data.content[index],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          );
        },
      ),
    );
  }
}
