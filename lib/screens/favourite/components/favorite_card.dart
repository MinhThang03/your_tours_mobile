import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:your_tours_mobile/screens/room_detail/room_detail_screen.dart';

import '../../../components/rating_bar.dart';
import '../../../constants.dart';

class FavoriteCard extends StatefulWidget {
  const FavoriteCard({Key? key}) : super(key: key);

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  bool _isFavourited = true;

  void _toggleFavorite() {
    setState(() {
      _isFavourited = !_isFavourited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
              return RoomDetailScreen();
            },
          ),
        );
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
                      child: Image.asset(
                        'assets/png/room1.png',
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
                                'assets/icons/Heart Icon.svg',
                                width: 20,
                                height: 20,
                                color: kPrimaryColor,
                              )
                            : SvgPicture.asset(
                                'assets/icons/Heart Icon_2.svg',
                                width: 20,
                                height: 20,
                                color: Colors.red,
                              ),
                        onPressed: () {
                          _toggleFavorite();
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
                      Text('Nhà cho thuê 1 phòng ngủ',
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      RatingBarCommon(
                        maxRating: 5,
                        minRating: 5,
                        initialRating: 5,
                      ),
                      Row(
                        children: [
                          Text('3.000.000' + 'VNĐ'),
                          const Text('/tháng')
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/homeCard.svg',
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 4),
                          Text('50'),
                          const Text(
                            ' m²',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
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
                                '48 Hoa Sứ, Phường 7, Q.Phú Nhuận. ',
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
