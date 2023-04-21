import 'package:intl/intl.dart';

//date form mat yyyy-MM-DD HH:mm:ss
String getDayMonthFormat(String date) {
  List<String> dateArr = date.split("-");
  if (dateArr.length < 3) {
    return '';
  }
  int year = int.parse(dateArr[0]);
  int month = int.parse(dateArr[1]);
  String monthName = DateFormat('MMM').format(DateTime(year, month));
  return '${dateArr[2].split(' ')[0]} $monthName';
}
