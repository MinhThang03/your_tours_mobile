import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:your_tours_mobile/constants/api_url.dart';
import 'package:your_tours_mobile/models/requests/active_account_request.dart';
import 'package:your_tours_mobile/models/responses/error_response.dart';
import 'package:your_tours_mobile/models/responses/register_response.dart';

Future<SuccessResponse> activeAccountController(
    ActiveAccountRequest requestBody) async {
  try {
    http.Response response = await http.post(
      Uri.parse(domain + activeOtpUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody.toJson()),
    );

    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return SuccessResponse.fromJson(responseJson);
    }

    ErrorResponse errorResponse = ErrorResponse.fromJson(responseJson);
    throw FormatException(errorResponse.message);
  } on FormatException {
    rethrow;
  } catch (error) {
    throw Exception(error);
  }
}
