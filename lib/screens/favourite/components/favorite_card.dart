import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/apis/home_detail_controller.dart';
import 'package:your_tours_mobile/components/loading_overlay.dart';
import 'package:your_tours_mobile/controllers/favourite_controller.dart';
import 'package:your_tours_mobile/models/responses/home_detail_response.dart';
import 'package:your_tours_mobile/models/responses/home_page_response.dart';
import 'package:your_tours_mobile/screens/room_detail/room_detail_screen.dart';
import 'package:your_tours_mobile/services/handle_province_name.dart';

import '../../../constants.dart';

class FavoriteCard extends StatefulWidget {
  final MobileHomeInfo homeInfo;

  const FavoriteCard({Key? key, required this.homeInfo}) : super(key: key);

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  late HandleFavouriteController favoriteController;

  @override
  void initState() {
    favoriteController =
        HandleFavouriteController(widget.homeInfo.isFavorite.obs);
    super.initState();
  }

  Future<void> callHomeDetailFromApi() async {
    try {
      HomeDetailResponse response = await LoadingOverlay.of(context)
          .during(future: homeDetailController(widget.homeInfo.id));

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
          border: Border.all(color: kPrimaryColor, width: 1),
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
                      Obx(() => IconButton(
                            icon: favoriteController.isFavorite.value
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
                            onPressed: () async {
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
                          )),
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
