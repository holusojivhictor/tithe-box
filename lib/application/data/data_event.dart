part of 'data_bloc.dart';

@freezed
class DataEvent with _$DataEvent {
  const factory DataEvent.recordIncome({
    required String businessName,
    required String incomeAmount,
    required String description,
    required String frequency,
  }) = _RecordIncome;
}