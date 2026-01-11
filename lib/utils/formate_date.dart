import 'package:intl/intl.dart';

String formatDate(dynamic value) {
  if (value == null) return '';

  try {
    DateTime date;
    if (value is DateTime) {
      date = value;
    } else {
      date = DateTime.parse(value.toString());
    }
    return DateFormat('MMM d, yyyy').format(date); // Nov 15, 2024
  } catch (_) {
    return value.toString(); // if not a date, return as-is
  }
}