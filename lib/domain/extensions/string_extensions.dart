// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

extension StringExtensions on String? {
  bool get isNullEmptyOrWhitespace => this == null || this!.isEmpty || this!.trim().isEmpty;
  bool get isNotNullEmptyOrWhitespace => !isNullEmptyOrWhitespace;

  bool get isNullEmptyOrWhitespaceOrHasNull => this == null || this!.isEmpty || this!.contains('null');
  bool get isNotNullEmptyOrWhitespaceNorHasNull => !isNullEmptyOrWhitespaceOrHasNull;

  String formatTimeString({bool hasYear = false}) {
    final dateTimeString = hasYear ? '$this' : '2012-02-27 $this';
    final dateTime = DateTime.parse(dateTimeString);

    final dateFormat = DateFormat('h:mm a');
    final timeString = dateFormat.format(dateTime);

    return timeString;
  }

  String formatDateString({bool hasYear = false}) {
    final dateString = '$this';
    final date = DateTime.parse(dateString);

    final dateFormat = DateFormat(hasYear ? 'yMMMd' : 'd MMM yyyy');
    final parsedDateString = dateFormat.format(date);

    return parsedDateString;
  }

  String formatDateTimeString() {
    final dateString = '$this';
    final date = DateTime.parse(dateString);

    final dateFormat = DateFormat('d MMM h:mm a');
    final dateTime = dateFormat.format(date);

    return dateTime;
  }

  DateTime parseDateString() {
    final dateString = '$this';
    final date = DateTime.parse(dateString);

    return date;
  }

  int getMillisecondsSinceEpoch() {
    final dateString = '$this';
    final date = DateTime.parse(dateString);

    return date.millisecondsSinceEpoch;
  }
}
