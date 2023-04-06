class CancelBookingRequest {
  String bookingId;

  CancelBookingRequest({
    required this.bookingId,
  });

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
    };
  }
}
