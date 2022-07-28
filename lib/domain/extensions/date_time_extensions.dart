// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

extension DateTimeExceptions on DateTime {
  String formatDate() {
    final dateFormat = DateFormat('yMMMd');
    final parsedDateString = dateFormat.format(this);

    return parsedDateString;
  }
}