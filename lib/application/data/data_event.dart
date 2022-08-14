part of 'data_bloc.dart';

@freezed
class DataEvent with _$DataEvent {
  const factory DataEvent.recordIncome({
    required String businessName,
    required String incomeAmount,
    required String description,
    required String frequency,
  }) = _RecordIncome;

  const factory DataEvent.saveChurch({
    required String address,
    required String churchName,
    required String accountName,
    required String accountNumber,
    required String countryCode,
    required String bankName,
    required String bankCode,
    required List<String> serviceDays,
  }) = _SaveChurch;
}
