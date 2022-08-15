import 'package:flutter/material.dart';

enum TransactionStatus {
  failed(Color(0xFFFB9191)),
  pending(Color(0xFF9EDDF8)),
  successful(Color(0xFF9BD29D));

  final Color color;
  const TransactionStatus(this.color);
}
