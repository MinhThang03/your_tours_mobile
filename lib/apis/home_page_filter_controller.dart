import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:your_tours_mobile/constants/api_url.dart';
import 'package:your_tours_mobile/models/responses/error_response.dart';
import 'package:your_tours_mobile/models/responses/home_info_response.dart';
import 'package:your_tours_mobile/services/token_handler.dart';

Future<GetHomePageResponse> homePageFilterController(
    String? amenityId, String? province) async {
  try {
    String? token = await getToken();
    if (token == null) {
      throw const FormatException("Lỗi chưa đăng nhập");
    }

    String amenityParam = '';
    String provinceParam = '';

    if (amenityId != null) {
      amenityParam = "&amenityId=$amenityId";
    }

    if (province != null) {
      provinceParam = "&province=$province";
    }

    http.Response response = await http.get(headers: <String, String>{
      'Authorization': 'Bearer $token',
    }, Uri.parse(domain + homePageFilterUrl + amenityParam + provinceParam));

    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      GetHomePageResponse homePageFilterResponse =
          GetHomePageResponse.fromJson(responseJson);
      return homePageFilterResponse;
    }

    ErrorResponse errorResponse = ErrorResponse.fromJson(responseJson);
    throw FormatException(errorResponse.message);
  } on FormatException {
    rethrow;
  } catch (error) {
    throw FormatException(error.toString());
  }
}

Future<GetHomePageResponse> homePageApi(String sort) async {
  try {
    String? token = await getToken();
    if (token == null) {
      throw const FormatException("Lỗi chưa đăng nhập");
    }

    String sortParam = '';

    switch (sort) {
      case 'New':
        sortParam = '&sort=NEW';
        break;
      case 'Top Views':
        sortParam = '&sort=VIEW';
        break;
      case 'Top Rates':
        sortParam = '&sort=RATE';
        break;
      case 'Top Booking':
        sortParam = '&sort=TRENDING';
        break;
      case 'Top Like':
        sortParam = '&sort=FAVORITE';
        break;
      default:
        break;
    }

    String urlBuilder = getHomePage.replaceAll('{sort}', sortParam);

    http.Response response = await http.get(headers: <String, String>{
      'Authorization': 'Bearer $token',
    }, Uri.parse(domain + urlBuilder));

    print(urlBuilder);

    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      GetHomePageResponse homePageFilterResponse =
          GetHomePageResponse.fromJson(responseJson);
      return homePageFilterResponse;
    }

    ErrorResponse errorResponse = ErrorResponse.fromJson(responseJson);
    throw FormatException(errorResponse.message);
  } on FormatException {
    rethrow;
  } catch (error) {
    throw FormatException(error.toString());
  }
}

Future<GetHomePageResponse> homeRecommendApi() async {
  try {
    String? token = await getToken();
    if (token == null) {
      throw const FormatException("Lỗi chưa đăng nhập");
    }

    http.Response response = await http.get(headers: <String, String>{
      'Authorization': 'Bearer $token',
    }, Uri.parse(domain + getHomeRecommend));

    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      GetHomePageResponse homePageFilterResponse =
          GetHomePageResponse.fromJson(responseJson);
      return homePageFilterResponse;
    }

    ErrorResponse errorResponse = ErrorResponse.fromJson(responseJson);
    throw FormatException(errorResponse.message);
  } on FormatException {
    rethrow;
  } catch (error) {
    throw FormatException(error.toString());
  }
}
