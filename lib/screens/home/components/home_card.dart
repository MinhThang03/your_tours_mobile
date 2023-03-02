import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:your_tours_mobile/constants.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({Key? key}) : super(key: key);

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  bool _isFavourited = true;


  void _toggleFavorite() {
    setState(() {
      _isFavourited = !_isFavourited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(
          start: 16.0, end: 16.0, top: 8, bottom: 8),
      height: 500,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          // border: Border.all(
          //   color: Colors.black,
          //   width: 1,
          // )
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                child: Image.asset(
                  'assets/png/room1.png',
                  fit: BoxFit.cover,
                  height: 340,
                  width: 366,
                ),
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
            ]),
            const SizedBox(
              height: 12,
            ),
            Text('Nhà cho thuê 1 phòng ngủ',
                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 2,
            ),
            RatingBar(
              itemSize: 27,
              maxRating: 5.0,
              minRating: 0.0,
              initialRating: 5,
              onRatingUpdate: (double rating) => {},
              ignoreGestures: true,
              allowHalfRating: true,
              ratingWidget: RatingWidget(
                empty: const Icon(
                  Icons.star_border_rounded,
                  color: kPrimaryColor,
                ),
                full: const Icon(
                  Icons.star_rounded,
                  color: kPrimaryColor,
                ),
                half: const Icon(
                  Icons.star_half_rounded,
                  color: kPrimaryColor,
                ),
              ),
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
    );
  }
}
