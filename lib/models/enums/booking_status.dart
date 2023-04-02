enum BookingStatusEnum { WAITING, CHECK_IN, CHECK_OUT, CANCELED }

extension BookingStatusEnumExtension on BookingStatusEnum {
  String get description {
    switch (this) {
      case BookingStatusEnum.WAITING:
        return 'Đang chờ';
      case BookingStatusEnum.CHECK_IN:
        return 'Đã nhận phòng';
      case BookingStatusEnum.CHECK_OUT:
        return 'Đã trả phòng';
      case BookingStatusEnum.CANCELED:
        return 'Đã hủy';
      default:
        return '';
    }
  }
}

String getDescriptionBookingStatus(String status) {
  switch (status) {
    case 'WAITING':
      return 'Đang chờ';
    case 'CHECK_IN':
      return 'Đã nhận phòng';
    case 'CHECK_OUT':
      return 'Đã trả phòng';
    case 'CANCELED':
      return 'Đã hủy';
    default:
      return '';
  }
}
