class UpdateImageResponse {
  bool success;
  ImageResponse data;

  UpdateImageResponse({
    required this.success,
    required this.data,
  });

  factory UpdateImageResponse.fromJson(Map<String, dynamic> json) =>
      UpdateImageResponse(
        success: json["success"],
        data: ImageResponse.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class ImageResponse {
  String previewUrl;
  DateTime createDate;

  ImageResponse({
    required this.previewUrl,
    required this.createDate,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) => ImageResponse(
        previewUrl: json["previewUrl"],
        createDate: DateTime.parse(json["createDate"]),
      );

  Map<String, dynamic> toJson() => {
        "previewUrl": previewUrl,
        "createDate": createDate.toIso8601String(),
      };
}
