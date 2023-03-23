class UserInfoResponse {
  UserInfoResponse({required this.success, this.data});

  bool success;
  UserInfo? data;

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      UserInfoResponse(
        success: json["success"] as bool,
        data: json["data"] != null ? UserInfo.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
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
