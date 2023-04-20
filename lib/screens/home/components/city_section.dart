import 'package:flutter/material.dart';

class HomeCity extends StatefulWidget {
  const HomeCity({Key? key}) : super(key: key);

  @override
  State<HomeCity> createState() => _HomeCityState();
}

class _HomeCityState extends State<HomeCity> {
  @override
  void initState() {
    super.initState();
  }

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
            child: const CityCard(
              icon:
                  "https://cdn.getyourguide.com/img/location/58c9218fb83cb.jpeg/75.jpg",
              text: "Hà Nội",
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            child: Image.network(
              widget.icon,
              fit: BoxFit.cover,
              height: 60,
              width: 60,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            widget.text,
          ),
        ],
      ),
    );
  }
}
