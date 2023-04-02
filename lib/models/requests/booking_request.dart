class BookingRequest {
  BookingRequest({
    required this.dateStart,
    required this.dateEnd,
    this.paymentMethod,
    required this.homeId,
    required this.guests,
    this.moneyPayed,
  });

  DateTime dateStart;
  DateTime dateEnd;
  String? paymentMethod;
  String homeId;
  List<Guest> guests;
  double? moneyPayed;

  Map<String, dynamic> toJson() => {
        "dateStart":
            "${dateStart.year.toString().padLeft(4, '0')}-${dateStart.month.toString().padLeft(2, '0')}-${dateStart.day.toString().padLeft(2, '0')}",
        "dateEnd":
            "${dateEnd.year.toString().padLeft(4, '0')}-${dateEnd.month.toString().padLeft(2, '0')}-${dateEnd.day.toString().padLeft(2, '0')}",
        "paymentMethod": paymentMethod,
        "homeId": homeId,
        "guests": List<dynamic>.from(guests.map((x) => x.toJson())),
        "moneyPayed": moneyPayed,
      };
}

class Guest {
  Guest({
    required this.guestCategory,
    required this.number,
  });

  String guestCategory;
  int number;

  Map<String, dynamic> toJson() => {
        "guestCategory": guestCategory,
        "number": number,
      };
}
