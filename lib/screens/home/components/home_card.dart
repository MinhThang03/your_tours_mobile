import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/screens/room_detail/room_detail_screen.dart';

import '../../../components/rating_bar.dart';
import '../../../models/Room.dart';

class HomeCard extends StatefulWidget {
  final int index;

  const HomeCard({Key? key, this.index = 0}) : super(key: key);

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  bool _isFavourited = true;
  late PageController _pageController;
  late Room _room;

  int _currentPage = 0;

  void _toggleFavorite() {
    setState(() {
      _isFavourited = !_isFavourited;
    });
  }

  @override
  void initState() {
    _room = RoomList.rooms[widget.index];
    _pageController = PageController(initialPage: _currentPage, keepPage: true);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
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
        )
      },
      child: Container(
        margin: const EdgeInsetsDirectional.only(
            start: 16.0, end: 16.0, top: 8, bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 360,
                child: Stack(children: [
                  PageView.builder(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _room.imagePath.length,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                        child: Image.asset(
                          _room.imagePath[index],
                          fit: BoxFit.cover,
                          height: 340,
                          width: 366,
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 0.5,
                    right: 0.5,
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
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                  )
                ]),
              ),
              const SizedBox(
                height: 12,
              ),
              Text('Nhà cho thuê 1 phòng ngủ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                  )),
              const SizedBox(
                height: 2,
              ),
              RatingBarCommon(
                maxRating: 5,
                minRating: 0,
                initialRating: 5,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/homeCard.svg',
                    width: 20,
                    height: 20,
                    color: Colors.red,
                  ),
                  SizedBox(width: 5),
                  Text(
                    '50 m2',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/location.svg',
                    width: 20,
                    height: 20,
                    color: Colors.red,
                  ),
                  SizedBox(width: 5),
                  Text(
                    '48 Hoa Sứ, Phường 7, Q.Phú Nhuận. ',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Text('3.000.000' ' VNĐ',
                  style: TextStyle(
                      fontSize: 16,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _room.imagePath.length; i++) {
      indicators.add(
        i == _currentPage
            ? _buildPageIndicatorItem(true)
            : _buildPageIndicatorItem(false),
      );
    }
    return indicators;
  }

  Widget _buildPageIndicatorItem(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8.0,
      width: isActive ? 8.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}
