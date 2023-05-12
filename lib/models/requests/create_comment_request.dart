class CreateCommentRequest {
  String bookId;
  double rates;
  String? comment;

  CreateCommentRequest(
      {required this.bookId, required this.rates, this.comment});

  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'rates': rates,
      'comment': comment,
    };
  }
}
