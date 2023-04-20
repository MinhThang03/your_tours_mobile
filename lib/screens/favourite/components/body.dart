import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:your_tours_mobile/components/loading_api_widget.dart';

import '../../../apis/favourite_apis.dart';
import '../../../models/responses/home_info_response.dart';
import '../../../size_config.dart';
import 'favorite_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<HomeInfoResponse?> _fetchDataFavouriteFromApi() async {
    try {
      final response = await favouritePageApi();
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
    return LoadApiWidget<HomeInfoResponse?>(
        successBuilder: (context, response) {
          return successWidget(context, response!);
        },
        fetchDataFunction: _fetchDataFavouriteFromApi());
  }

  Widget successWidget(BuildContext context, HomeInfoResponse response) {
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
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: getProportionateScreenWidth(10)),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: response.data.content.length,
                  itemBuilder: (context, index) {
                    return FavoriteCard(homeInfo: response.data.content[index]);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
    );
  }
}
