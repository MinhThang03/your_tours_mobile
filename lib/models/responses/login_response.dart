import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({required this.success, this.data});

  bool success;
  Data? data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"] as bool,
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.accessToken,
    this.expiresIn,
    this.refreshExpiresIn,
    this.refreshToken,
    this.tokenType,
    this.idToken,
    this.notBeforePolicy,
    this.sessionState,
    this.scope,
    this.error,
    this.errorDescription,
    this.errorUri,
    this.userInfo,
  });

  String? accessToken;
  int? expiresIn;
  int? refreshExpiresIn;
  String? refreshToken;
  String? tokenType;
  String? idToken;
  int? notBeforePolicy;
  String? sessionState;
  String? scope;
  String? error;
  String? errorDescription;
  String? errorUri;
  UserInfo? userInfo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
        refreshExpiresIn: json["refresh_expires_in"],
        refreshToken: json["refresh_token"],
        tokenType: json["token_type"],
        idToken: json["id_token"],
        notBeforePolicy: json["not-before-policy"],
        sessionState: json["session_state"],
        scope: json["scope"],
        error: json["error"],
        errorDescription: json["error_description"],
        errorUri: json["error_uri"],
        userInfo: UserInfo.fromJson(json["userInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "expires_in": expiresIn,
        "refresh_expires_in": refreshExpiresIn,
        "refresh_token": refreshToken,
        "token_type": tokenType,
        "id_token": idToken,
        "not-before-policy": notBeforePolicy,
        "session_state": sessionState,
        "scope": scope,
        "error": error,
        "error_description": errorDescription,
        "error_uri": errorUri,
        "userInfo": userInfo?.toJson(),
      };
}

class UserInfo {
  UserInfo({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.avatar,
    this.status,
    this.role,
    this.isOwner,
    this.owner,
  });

  String? id;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? dateOfBirth;
  String? gender;
  String? address;
  String? avatar;
  String? status;
  String? role;
  bool? isOwner;
  bool? owner;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        fullName: json["fullName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        dateOfBirth: json["dateOfBirth"],
        gender: json["gender"],
        address: json["address"],
        avatar: json["avatar"],
        status: json["status"],
        role: json["role"],
        isOwner: json["isOwner"],
        owner: json["owner"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "address": address,
        "avatar": avatar,
        "status": status,
        "role": role,
        "isOwner": isOwner,
        "owner": owner,
      };
}
