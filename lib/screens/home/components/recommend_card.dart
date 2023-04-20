import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:your_tours_mobile/constants.dart';

class HomeRecommendCardList extends StatefulWidget {
  const HomeRecommendCardList({Key? key}) : super(key: key);

  @override
  State<HomeRecommendCardList> createState() => _HomeRecommendCardListState();
}

class _HomeRecommendCardListState extends State<HomeRecommendCardList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return HomeRecommendCard();
      },
    );
  }
}

class HomeRecommendCard extends StatefulWidget {
  final int index;

  const HomeRecommendCard({Key? key, this.index = 0}) : super(key: key);

  @override
  State<HomeRecommendCard> createState() => _HomeRecommendCardState();
}

class _HomeRecommendCardState extends State<HomeRecommendCard> {
  bool _isFavourited = false;
  late PageController _pageController;

  int _currentPage = 0;
  List<String> images = [
    'https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=1024x768',
    'https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=1024x768',
    'https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=1024x768',
    'https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=1024x768',
    'https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=1024x768'
  ];

  @override
  void initState() {
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
      onTap: () => {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          //
          // border: const Border(
          //   top: BorderSide(width: 1.0, color: kBody),
          //   bottom: BorderSide(width: 1.0, color: kBody),
          //   left: BorderSide(width: 1.0, color: kBody),
          //   right: BorderSide(width: 1.0, color: kBody),
          // ),
          color: kWhite,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(2, 8)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: images.length,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18.0),
                            topRight: Radius.circular(18.0)),
                        child: Image.network(
                          images[index],
                          fit: BoxFit.cover,
                          height: 132,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 12,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              blurRadius: 3,
                              offset: const Offset(0, 3)),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: _isFavourited
                              ? SvgPicture.asset(
                                  'assets/icons/Heart Icon_2.svg',
                                  width: 16,
                                  height: 16,
                                  color: kPrimaryColor,
                                )
                              : SvgPicture.asset(
                                  'assets/icons/Heart Icon.svg',
                                  width: 16,
                                  height: 16,
                                  color: Colors.red,
                                ),
                        ),
                      )),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Blue Nature",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        letterSpacing: 0,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/location_fill_icon.svg',
                              width: 20,
                              height: 20,
                              color: kSecondary,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "Ho Chi Minh",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/Star Icon.svg',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "5.0",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text('500 VNĐ',
                      style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 0,
                          color: kTextColor,
                          fontWeight: FontWeight.w900)),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < images.length; i++) {
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
