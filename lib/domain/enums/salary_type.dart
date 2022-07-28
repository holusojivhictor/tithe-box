import 'package:flutter/material.dart';

enum SalaryType {
  daily(Color(0xFFFBFCDA)),
  weekly(Color(0xFFF0F8E5)),
  monthly(Color(0xFFF9E4FE)),
  yearly(Color(0xFFE7F7FB)),
  random(Color(0xFFF2F2F2));

  final Color color;
  const SalaryType(this.color);
}