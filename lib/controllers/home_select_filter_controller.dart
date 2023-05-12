import 'package:get/get.dart';

class HomeSelectFilterController extends GetxController {
  RxString content = 'New'.obs;

  void selectItem(String text) {
    content.value = text;
  }
}
