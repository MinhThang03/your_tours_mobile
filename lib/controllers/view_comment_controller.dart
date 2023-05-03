import 'package:get/get.dart';

class HandleViewCommentController extends GetxController {
  RxDouble rates = (0.0).obs;
  RxString comment = ''.obs;
  RxBool view = false.obs;

  void setView(double rates, String comment) {
    this.rates.value = rates;
    this.comment.value = comment;
    view.value = true;
  }
}
