import 'package:get/get.dart';
import 'package:your_tours_mobile/models/responses/location_response.dart';
import 'package:your_tours_mobile/models/responses/user_response.dart';

class UserController extends GetxController {
  final Rx<UserInfo> userInfo;
  final Rx<UserLocation> location;

  UserController(this.userInfo, this.location);

  void setLocation(UserLocation value) {
    location.value = value;
  }
}
