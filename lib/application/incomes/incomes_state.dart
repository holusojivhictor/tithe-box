part of 'incomes_bloc.dart';

@freezed
class IncomesState with _$IncomesState {
  const factory IncomesState.loading() = _LoadingState;

  const factory IncomesState.loaded({
    required List<IncomeCardModel> incomes,
    @Default(false) bool isRefreshing,
    required double totalIncome,
    required SalaryType salaryType,
    required SalaryType tempSalaryType,
  }) = _LoadedState;
}
