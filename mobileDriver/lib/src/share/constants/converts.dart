import 'package:intl/intl.dart';

String convertFormatDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final String formatted = formatter.format(date);
  return formatted;
}

String convertFormatHour(DateTime date) {
  final DateFormat formatter = DateFormat('HH:mm');
  final String formatted = formatter.format(date);
  return formatted;
}

String checkDayInWeek(DateTime date) {
  String day = DateFormat('EEEE').format(date);
  switch (day) {
    case "Monday":
      return "hai";
    case "Tuesday":
      return "ba";
    case "Wednesday":
      return "tư";
    case "Thusday":
      return "năm";
    case "Friday":
      return "sáu";
    case "Sartuday":
      return "bảy";
    case "Sun day":
      return "Chủ nhật";
    default:
      break;
  }
  return "";
}
