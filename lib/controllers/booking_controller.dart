import 'package:get/get.dart';

class BookingSelectFilterController extends GetxController {
  RxString content = 'Active'.obs;

  void setContent(String text) {
    content.value = text;
  }
}
