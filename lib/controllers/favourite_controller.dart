import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/apis/favourite_apis.dart';
import 'package:your_tours_mobile/models/requests/favourite_request.dart';
import 'package:your_tours_mobile/models/responses/register_response.dart';

class HandleFavouriteController extends GetxController {
  final RxBool isFavorite;

  RxBool first = true.obs;
  RxString errorMessage = ''.obs;
  RxString message = ''.obs;

  HandleFavouriteController(this.isFavorite);

  Future<void> handleFavorite(BuildContext context, String homeId) async {
    try {
      SuccessResponse favouriteResponse =
          await favouriteHandlerApi(FavouriteRequest(homeId: homeId));

      isFavorite.value = !isFavorite.value;

      if (favouriteResponse.data.success == true) {
        message.value = 'Thêm vào danh sách yêu thích thành công';
      } else {
        message.value = 'Xóa khỏi danh sách yêu thích thành công';
      }
    } on FormatException catch (error) {
      errorMessage.value = error.message;
    }
  }
}