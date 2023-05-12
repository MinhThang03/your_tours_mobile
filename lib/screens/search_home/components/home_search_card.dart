import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:your_tours_mobile/apis/home_detail_apis.dart';
import 'package:your_tours_mobile/components/loading_overlay.dart';
import 'package:your_tours_mobile/models/responses/home_detail_response.dart';
import 'package:your_tours_mobile/models/responses/home_page_response.dart';
import 'package:your_tours_mobile/screens/room_detail/room_detail_screen.dart';
import 'package:your_tours_mobile/services/handle_province_name.dart';

import '../../../apis/favourite_apis.dart';
import '../../../constants.dart';
import '../../../models/requests/favourite_request.dart';
import '../../../models/responses/register_response.dart';

class HomeSearchCard extends StatefulWidget {
  final MobileHomeInfo homeInfo;

  const HomeSearchCard({Key? key, required this.homeInfo}) : super(key: key);

  @override
  State<HomeSearchCard> createState() => _HomeSearchCardState();
}

class _HomeSearchCardState extends State<HomeSearchCard> {
  bool _isFavourited = false;

  @override
  void initState() {
    _isFavourited = widget.homeInfo.isFavorite;
    super.initState();
  }

  Future<void> _handleFavourite() async {
    try {
      SuccessResponse favouriteResponse = await favouriteHandlerApi(
          FavouriteRequest(homeId: widget.homeInfo.id));

      setState(() {
        _isFavourited = !_isFavourited;
      });

      if (!mounted) return;

      if (favouriteResponse.success == true) {
        AnimatedSnackBar.material(
          'Thêm vào danh sách yêu thích thành công',
          type: AnimatedSnackBarType.success,
          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
          desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
        ).show(context);
      } else {
        AnimatedSnackBar.material(
          'Xóa khỏi danh sách yêu thích thành công',
          type: AnimatedSnackBarType.error,
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

  Future<void> callHomeDetailFromApi() async {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callHomeDetailFromApi();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(color: kSmoke, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(18.0)),
              child: Image.network(
                widget.homeInfo.thumbnail,
                fit: BoxFit.cover,
                height: 110,
                width: 110,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(widget.homeInfo.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      IconButton(
                        icon: _isFavourited
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
                        onPressed: () {
                          _handleFavourite();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/location_fill_icon.svg',
                              width: 18,
                              height: 18,
                              color: kSmoke,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              getShortProvinceName(
                                  widget.homeInfo.provinceName),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/Star Icon.svg',
                              width: 18,
                              height: 18,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '5.0',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${widget.homeInfo.costPerNightDefault.toInt()} VNĐ',
                        style: const TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      const Text('/Night')
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
