import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/apis/amenities_controller.dart';
import 'package:your_tours_mobile/components/loading_api_widget.dart';
import 'package:your_tours_mobile/components/shimmer_loading.dart';
import 'package:your_tours_mobile/controllers/search_controller.dart';
import 'package:your_tours_mobile/models/responses/amenities_filter_response.dart';

import '../../../size_config.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Future<AmenitiesFilterResponse?> _fetchDataAmenitiesFromApi() async {
    try {
      return await amenitiesController();
    } on FormatException catch (error) {
      AnimatedSnackBar.material(
        error.message,
        type: AnimatedSnackBarType.error,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      ).show(context);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return LoadApiWidget<AmenitiesFilterResponse?>(
        autoCache: true,
        successBuilder: (context, response) {
          return successWidget(context, response!);
        },
        loadingBuilder: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: List.generate(
                  6,
                  (index) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: ShimmerLoading(
                            width: 40,
                            height: 40,
                            boxShape: BoxShape.rectangle),
                      )),
            ),
          ),
        ),
        fetchDataFunction: _fetchDataAmenitiesFromApi());
  }

  Widget successWidget(BuildContext context, AmenitiesFilterResponse response) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            response.data.content.length,
            (index) => CategoryCard(
              icon: response.data.content[index].icon,
              text: response.data.content[index].name,
              id: response.data.content[index].id,
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    this.id,
  }) : super(key: key);

  final String? icon, text, id;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  SearchController searchController = Get.find<SearchController>();

  bool _isSelected() {
    if (searchController.amenityId.value == '' && widget.id == null) {
      return true;
    }

    if (searchController.amenityId.value == widget.id) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        searchController.setAmenity(widget.id);
      },
      child: Obx(() => Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: _isSelected() ? Colors.grey : Colors.white,
                  width: _isSelected() ? 2.0 : 0,
                ),
              ),
            ),
            child: SizedBox(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    height: getProportionateScreenWidth(40),
                    width: getProportionateScreenWidth(40),
                    child: Image.network(
                      widget.icon!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        widget.text!,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 12,
                          color: _isSelected()
                              ? const Color(0xFFFF7643)
                              : Colors.black,
                          fontWeight: _isSelected()
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      )),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          )),
    );
  }
}