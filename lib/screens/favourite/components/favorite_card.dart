import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:your_tours_mobile/components/loading_overlay.dart';
import 'package:your_tours_mobile/controllers/home_detail_controller.dart';
import 'package:your_tours_mobile/models/responses/home_detail_response.dart';
import 'package:your_tours_mobile/models/responses/home_info_response.dart';
import 'package:your_tours_mobile/screens/room_detail/room_detail_screen.dart';

import '../../../components/rating_bar.dart';
import '../../../constants.dart';
import '../../../controllers/favourite_controller.dart';
import '../../../models/requests/favourite_request.dart';
import '../../../models/responses/register_response.dart';

class FavoriteCard extends StatefulWidget {
  final HomeInfo homeInfo;

  const FavoriteCard({Key? key, required this.homeInfo}) : super(key: key);

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  bool _isFavourited = false;

  @override
  void initState() {
    _isFavourited = widget.homeInfo.isFavorite ?? false;
    super.initState();
  }

  Future<void> _handleFavourite() async {
    try {
      SuccessResponse favouriteResponse = await favouriteHandlerController(
          FavouriteRequest(homeId: widget.homeInfo.id));

      setState(() {
        _isFavourited = !_isFavourited;
      });

      if (!mounted) return;

      if (favouriteResponse.success == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Thêm vào danh sách yêu thích thành công"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Xóa khỏi danh sách yêu thích thành công"),
          ),
        );
      }
    } on FormatException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
        ),
      );
    }
  }

  Future<void> _callHomeDetailFromApi() async {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _callHomeDetailFromApi();
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0, left: 16, top: 8),
        child: Container(
          height: 168,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, bottom: 20, top: 20, right: 10),
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      child: Image.network(
                        widget.homeInfo.thumbnail!,
                        fit: BoxFit.cover,
                        height: 136,
                        width: 128,
                      ),
                    ),
                    Positioned(
                      top: -10,
                      right: -6,
                      child: IconButton(
                        icon: _isFavourited
                            ? SvgPicture.asset(
                          'assets/icons/Heart Icon_2.svg',
                                width: 20,
                                height: 20,
                                color: kPrimaryColor,
                              )
                            : SvgPicture.asset(
                          'assets/icons/Heart Icon.svg',
                                width: 20,
                                height: 20,
                                color: Colors.red,
                              ),
                        onPressed: () {
                          _handleFavourite();
                        },
                      ),
                    ),
                  ]),
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.homeInfo.name!,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      const RatingBarCommon(
                        maxRating: 5,
                        minRating: 5,
                        initialRating: 5,
                      ),
                      Row(
                        children: [
                          Text('${widget.homeInfo.costPerNightDefault}VNĐ'),
                          const Text('/đêm')
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     SvgPicture.asset(
                      //       'assets/icons/homeCard.svg',
                      //       width: 18,
                      //       height: 18,
                      //     ),
                      //     const SizedBox(width: 4),
                      //     Text('50'),
                      //     const Text(
                      //       ' m²',
                      //       style: TextStyle(fontSize: 12),
                      //     )
                      //   ],
                      // ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/location.svg',
                              width: 18,
                              height: 18,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              flex: 3,
                              child: Text(
                                widget.homeInfo.provinceName ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
