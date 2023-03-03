import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constants.dart';

class RatingBarCommon extends StatefulWidget {
  final double maxRating;
  final double minRating;
  final double initialRating;

  const RatingBarCommon(
      {Key? key,
      required this.maxRating,
      required this.minRating,
      required this.initialRating})
      : super(key: key);

  @override
  State<RatingBarCommon> createState() => _RatingBarCommonState();
}

class _RatingBarCommonState extends State<RatingBarCommon> {
  @override
  Widget build(BuildContext context) {
    return RatingBar(
      itemSize: 24,
      maxRating: widget.maxRating,
      minRating: widget.minRating,
      initialRating: widget.initialRating,
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
    );
  }
}
