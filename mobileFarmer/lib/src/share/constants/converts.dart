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