class GetPageCommentResponse {
  bool success;
  Data data;

  GetPageCommentResponse({
    required this.success,
    required this.data,
  });

  factory GetPageCommentResponse.fromJson(Map<String, dynamic> json) =>
      GetPageCommentResponse(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  List<CommentInfo> content;
  int pageNumber;
  int pageSize;
  int totalElements;

  Data({
    required this.content,
    required this.pageNumber,
    required this.pageSize,
    required this.totalElements,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        content: List<CommentInfo>.from(
            json["content"].map((x) => CommentInfo.fromJson(x))),
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        totalElements: json["totalElements"],
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "totalElements": totalElements,
      };
}

class CommentInfo {
  String? avatar;
  String fullName;
  double rates;
  String comment;
  String userId;
  String homeId;
  String bookingId;
  String lateModifiedDate;

  CommentInfo({
    this.avatar,
    required this.fullName,
    required this.rates,
    required this.comment,
    required this.userId,
    required this.homeId,
    required this.bookingId,
    required this.lateModifiedDate,
  });

  factory CommentInfo.fromJson(Map<String, dynamic> json) => CommentInfo(
        avatar: json["avatar"],
        fullName: json["fullName"],
        rates: json["rates"],
        comment: json["comment"],
        userId: json["userId"],
        homeId: json["homeId"],
        bookingId: json["bookingId"],
        lateModifiedDate: json["lateModifiedDate"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "fullName": fullName,
        "rates": rates,
        "comment": comment,
        "userId": userId,
        "homeId": homeId,
        "bookingId": bookingId,
        "lateModifiedDate": lateModifiedDate,
      };
}
