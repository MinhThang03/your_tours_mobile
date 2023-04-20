import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/controllers/favourite_controller.dart';

class HomeFilterCardList extends StatefulWidget {
  const HomeFilterCardList({Key? key}) : super(key: key);

  @override
  State<HomeFilterCardList> createState() => _HomeFilterCardListState();
}

class _HomeFilterCardListState extends State<HomeFilterCardList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          10,
          (index) => GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                HomeFilterCard(),
                const SizedBox(
                  width: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class HomeFilterCard extends StatelessWidget {
  HandleFavouriteController favoriteController = HandleFavouriteController();

  HomeFilterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 236,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  blurRadius: 2,
                  offset: const Offset(0, 1)),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                      child: Image.network(
                        "https://pearlriverhotel.vn/wp-content/uploads/2019/07/pearl-river-hotel-home1.jpg",
                        fit: BoxFit.cover,
                        height: 156,
                        width: 186,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(
                                Icons.star_purple500_outlined,
                                size: 18,
                                color: Colors.orange,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                "5.0",
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      )),
                  Positioned(
                    bottom: 0,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {
                        favoriteController.handleFavorite(context);
                      },
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
                          child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Obx(
                                () => favoriteController.isFavorite.value
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
                              ))),
                    ),
                  ),
                ]),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Blue Nature",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/location_fill_icon.svg',
                                width: 18,
                                height: 18,
                                color: const Color(0xFFFC674E),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Text(
                                "Ho Chi Minh",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            '80đ',
                            style: TextStyle(color: kSecondary),
                          ),
                          Text('/Night'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
