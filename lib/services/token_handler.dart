import 'package:shared_preferences/shared_preferences.dart';

import '../models/responses/user_response.dart';

Future<void> saveToken(String? token) async {
  // Lưu token vào SharedPreferences
  if (token != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}

Future<void> saveUserInfo(UserInfo? userInfo) async {
  if (userInfo != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userInfo.id.toString());
  }
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

Future<String?> getDataFromSharedPreferences(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(name);
}

Future<void> deleteToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
}
