import 'package:tithe_box/domain/enums/enums.dart';

class ChurchCardModel {
  final String id;
  final String name;
  final List<ChurchServiceDay> serviceDays;
  final String accountId;
  final String address;

  ChurchCardModel({
    required this.id,
    required this.name,
    required this.serviceDays,
    required this.accountId,
    required this.address,
  });
}
