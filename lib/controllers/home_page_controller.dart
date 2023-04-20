import 'package:get/get.dart';
import 'package:your_tours_mobile/models/responses/home_info_response.dart';

class HomePageController extends GetxController {
  Rx<GetHomePageResponse>? response;

  void loadContent(GetHomePageResponse content) {
    response = content.obs;
    print(
        "tessssssst ------------ ${response?.value.data.content[0].toJson() ?? ''}");
  }
}
