import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:your_tours_mobile/apis/home_page_filter_api.dart';
import 'package:your_tours_mobile/components/loading_api_widget.dart';
import 'package:your_tours_mobile/components/shimmer_loading.dart';
import 'package:your_tours_mobile/models/responses/home_page_response.dart';

import '../../../size_config.dart';
import 'favorite_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  Future<HomePageResponse?> _fetchDataFavouriteFromApi() async {
    try {
      return await homeFavoriteApi();
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
        fetchDataFunction: _fetchDataFavouriteFromApi());
  }

  Widget successWidget(BuildContext context, HomePageResponse response) {
    return SingleChildScrollView(
      child: response.data.content.isEmpty
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              child: Text(
                "Hiện chưa có danh sách yêu thích",
                style: TextStyle(fontSize: getProportionateScreenWidth(16)),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: response.data.content.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    FavoriteCard(homeInfo: response.data.content[index]),
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
