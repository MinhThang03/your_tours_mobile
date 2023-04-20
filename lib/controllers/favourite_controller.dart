import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HandleFavouriteController extends GetxController {
  RxBool isFavorite = false.obs;
  RxString error = ''.obs;

  void handleFavorite(BuildContext context) {
    AnimatedSnackBar.material(
      'Thêm vào danh sách yêu thích thành công',
      type: AnimatedSnackBarType.success,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
    ).show(context);

    isFavorite.value = !isFavorite.value;
  }
}