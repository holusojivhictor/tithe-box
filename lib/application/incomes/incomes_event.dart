part of 'incomes_bloc.dart';

@freezed
class IncomesEvent with _$IncomesEvent {
  const factory IncomesEvent.init() = _Init;

  const factory IncomesEvent.refresh() = _Refresh;

  const factory IncomesEvent.salaryTypeChanged(SalaryType salaryType) = _SalaryTypeChanged;

  const factory IncomesEvent.applyFilterChanges() = _ApplyFilterChanges;
}
