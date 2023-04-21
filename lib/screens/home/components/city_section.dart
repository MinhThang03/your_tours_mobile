import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/apis/province_api.dart';
import 'package:your_tours_mobile/components/loading_api_widget.dart';
import 'package:your_tours_mobile/components/shimmer_loading.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/controllers/user_controller.dart';
import 'package:your_tours_mobile/models/responses/location_response.dart';
import 'package:your_tours_mobile/models/responses/province_response.dart';

class HomeCity extends StatefulWidget {
  const HomeCity({Key? key}) : super(key: key);

  @override
  State<HomeCity> createState() => _HomeCityState();
}

class _HomeCityState extends State<HomeCity> {
  Future<GetListProvinceResponse?> _fetchDataListProvinceApi() async {
    try {
      return await getListProvinceApi();
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
    return LoadApiWidget<GetListProvinceResponse?>(
        autoCache: true,
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
                        width: 60,
                        height: 60,
                      ),
                    )),
          ),
        ),
        fetchDataFunction: _fetchDataListProvinceApi());
  }

  Widget successWidget(BuildContext context, GetListProvinceResponse response) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          response.data.length,
          (index) => GestureDetector(
            onTap: () {},
            child: CityCard(
              icon: response.data[index].thumbnail,
              text: response.data[index].enName,
            ),
          ),
        ),
      ),
    );
  }
}

class CityCard extends StatefulWidget {
  const CityCard({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final String icon, text;

  @override
  State<CityCard> createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> {
  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Obx(
          () => GestureDetector(
            onTap: () {
              userController.setLocation(UserLocation(cityName: widget.text));
            },
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: kPrimaryColor,
                      width:
                          widget.text == userController.location.value.cityName
                              ? 2
                              : 0,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    child: Image.network(
                      widget.icon,
                      fit: BoxFit.cover,
                      height:
                          widget.text == userController.location.value.cityName
                              ? 56
                              : 60,
                      width:
                          widget.text == userController.location.value.cityName
                              ? 56
                              : 60,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.text,
                  style: TextStyle(
                      color:
                          widget.text == userController.location.value.cityName
                              ? kPrimaryColor
                              : kTextColor),
                ),
              ],
            ),
          ),
        ));
  }
}
