import 'package:flutter/material.dart';
import 'package:your_tours_mobile/models/responses/home_detail_response.dart';

import '../../../constants.dart';

class AmenityCard extends StatelessWidget {
  final AmenitiesView amenitiesView;

  const AmenityCard({Key? key, required this.amenitiesView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
        border: Border.all(color: kSmoke, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Image.network(
          amenitiesView.icon!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
