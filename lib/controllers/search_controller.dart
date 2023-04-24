import 'package:get/get.dart';

class SearchController extends GetxController {
  RxString keyword = ''.obs;
  RxString amenityId = ''.obs;

  void setSearch(String? keyword, String? amenityId) {
    setKeyword(keyword);
    setAmenity(amenityId);
  }

  void setAmenity(String? amenityId) {
    if (amenityId != null) {
      this.amenityId.value = amenityId;
    } else {
      this.amenityId.value = '';
    }
  }

  void setKeyword(String? keyword) {
    if (keyword != null) {
      this.keyword.value = keyword;
    } else {
      this.keyword.value = '';
    }
  }
}
