class FavouriteRequest {
  String homeId;

  FavouriteRequest({
    required this.homeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'homeId': homeId,
    };
  }
}
