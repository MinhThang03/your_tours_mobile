import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:your_tours_mobile/constants/api_url.dart';
import 'package:your_tours_mobile/models/requests/forgot_password_request.dart';
import 'package:your_tours_mobile/models/responses/error_response.dart';
import 'package:your_tours_mobile/models/responses/register_response.dart';

Future<SuccessResponse> forgotPasswordApi(
    ForgotPasswordRequest requestBody) async {
  try {
    if (requestBody.email.isEmpty) {
      throw const FormatException("Vui lòng nhập email");
    }

    log(name: 'REQUEST FORGOT PASSWORD:', requestBody.toJson().toString());

    http.Response response = await http.post(
      Uri.parse(domain + forgotPassword),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody.toJson()),
    );

    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));

    log(name: 'RESPONSE FORGOT PASSWORD:', responseJson.toString());

    if (response.statusCode == 200) {
      return SuccessResponse.fromJson(responseJson);
    }

    ErrorResponse errorResponse = ErrorResponse.fromJson(responseJson);

    if (errorResponse.code == '4090000') {
      throw const FormatException("Nhập không đúng định dạng mật khẩu");
    }

    throw FormatException(errorResponse.message);
  } on FormatException {
    rethrow;
  } catch (error) {
    throw Exception(error);
  }
}

Future<SuccessResponse> resetPasswordApi(
    ResetPasswordRequest requestBody) async {
  try {
    log(name: 'REQUEST RESET PASSWORD:', requestBody.toJson().toString());

    http.Response response = await http.post(
      Uri.parse(domain + resetPassword),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody.toJson()),
    );

    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));

    log(name: 'RESPONSE RESET PASSWORD:', responseJson.toString());

    if (response.statusCode == 200) {
      return SuccessResponse.fromJson(responseJson);
    }

    ErrorResponse errorResponse = ErrorResponse.fromJson(responseJson);

    if (errorResponse.code == '4090000') {
      throw const FormatException("Nhập không đúng định dạng mật khẩu");
    }

    throw FormatException(errorResponse.message);
  } on FormatException {
    rethrow;
  } catch (error) {
    throw Exception(error);
  }
}
