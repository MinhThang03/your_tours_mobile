import 'package:flutter/material.dart';
import 'package:your_tours_mobile/screens/home/components/home_card.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

// class Body extends StatelessWidget {
//
//   const Body({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Categories(),
//         Expanded(
//           child: SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   // SizedBox(height: getProportionateScreenHeight(20)),
//                   // HomeHeader(),
//                   SizedBox(height: getProportionateScreenWidth(10)),
//                   DiscountBanner(),
//                   // Categories(),
//                   SpecialOffers(),
//                   SizedBox(height: getProportionateScreenWidth(30)),
//
//                   SpecialOffers(),
//                   SizedBox(height: getProportionateScreenWidth(30)),
//                   SpecialOffers(),
//                   SizedBox(height: getProportionateScreenWidth(30)),
//                   SpecialOffers(),
//                   SizedBox(height: getProportionateScreenWidth(30)),
//                   SpecialOffers(),
//                   SizedBox(height: getProportionateScreenWidth(30)),
//
//                   PopularProducts(),
//                   SizedBox(height: getProportionateScreenWidth(30)),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return const HomeCard();
      },
    );
  }
}