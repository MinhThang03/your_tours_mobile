import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:your_tours_mobile/constants.dart';

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
    return Container(
      margin: const EdgeInsetsDirectional.only(
          start: 16.0, end: 16.0, top: 8, bottom: 8),
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: Colors.black,
          width: 2,
        )
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
                  height: 240,
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
                          color: Colors.black,
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
                style: TextStyle(fontSize: 18, color: Colors.black)),
            const SizedBox(
              height: 8,
            ),
            Text('3.000.000' ' VNĐ',
                style: TextStyle(
                    fontSize: 16,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 8,
            ),
            Text(
              '48 Hoa Sứ, Phường 7, Q.Phú Nhuận. ',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
