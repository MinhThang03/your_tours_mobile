import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:your_tours_mobile/size_config.dart';

class ShimmerLoading extends StatelessWidget {
  final BoxShape? boxShape;
  final double? width;
  final double? height;

  const ShimmerLoading({Key? key, this.boxShape, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                shape: boxShape ?? BoxShape.circle,
                color: Colors.white,
              ),
              width: width ?? 40,
              height: height ?? 40,
            )),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: width ?? 40,
            height: 8.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class ShimmerLoadingFavorite extends StatelessWidget {
  final BoxShape? boxShape;
  final double? width;
  final double? height;

  const ShimmerLoadingFavorite(
      {Key? key, this.boxShape, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                decoration: BoxDecoration(
                  shape: boxShape ?? BoxShape.circle,
                  color: Colors.white,
                ),
                width: width ?? 40,
                height: height ?? 40,
              )),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                Container(
                  width: SizeConfig.screenWidth - (width ?? 40) - 100,
                  height: 16.0,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 16.0,
                  width: SizeConfig.screenWidth - (width ?? 40) - 100,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 16.0,
                  width: SizeConfig.screenWidth - (width ?? 40) - 100,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
