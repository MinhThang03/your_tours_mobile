import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

import '../../../controllers/favourite_controller.dart';
import '../../../models/responses/home_info_response.dart';
import '../../../size_config.dart';
import 'favorite_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  HomeInfoResponse? _homeInfoResponse;

  @override
  void initState() {
    super.initState();
    _fetchDataFavouriteFromApi();
  }

  @override
  void dispose() {
    _homeInfoResponse = null;
    super.dispose();
  }

  Future<void> _fetchDataFavouriteFromApi() async {
    try {
      final response = await favouritePageController();
      setState(() {
        _homeInfoResponse = response;
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
    return SingleChildScrollView(
      child: (_homeInfoResponse?.data.content.length ?? 0) == 0
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
            itemCount: _homeInfoResponse?.data.content.length ?? 0,
            itemBuilder: (context, index) {
              return FavoriteCard(
                  homeInfo: _homeInfoResponse!.data.content[index]);
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
