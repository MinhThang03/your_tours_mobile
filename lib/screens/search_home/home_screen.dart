import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:your_tours_mobile/models/responses/home_info_response.dart';

import '../../apis/home_page_filter_controller.dart';
import 'components/body.dart';
import 'components/home_header.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/search_home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _amenityId;
  String? _province;

  HomeInfoResponse? _homeList;

  @override
  void initState() {
    super.initState();
    _fetchDataHomesFromApi();
  }

  @override
  void dispose() {
    _homeList = null; // phá vỡ reference tới _otherObject
    _amenityId = null;
    _province = null;
    super.dispose();
  }

  Future<void> _fetchDataHomesFromApi() async {
    try {
      final response = await homePageController(_amenityId, _province);
      setState(() {
        _homeList = response;
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
      body: Column(
        children: [
          HomeHeader(
            onChangeSearch: (value) {
              setState(() {
                _province = value;
                _fetchDataHomesFromApi();
              });
            },
            onChangeTap: (value) {
              setState(() {
                _amenityId = value;
                _fetchDataHomesFromApi();
              });
            },
          ),
          Expanded(
              child: Body(
            homeList: _homeList?.data.content,
          )),
        ],
      ),
    );
  }
}
