import 'dart:ui';

import 'package:your_tours_mobile/constants.dart';

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
      return 'Chờ nhận phòng';
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

Color getColorDescriptionBookingStatus(String status) {
  switch (status) {
    case 'WAITING':
      return const Color(0xFF43b0f1);
    case 'CHECK_IN':
      return kPrimaryColor;
    case 'CHECK_OUT':
      return kPrimaryColor;
    case 'CANCELED':
      return kSecondaryColor;
    default:
      return kPrimaryColor;
  }
}
