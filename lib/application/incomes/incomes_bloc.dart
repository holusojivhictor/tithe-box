// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/domain/services/services.dart';

part 'incomes_bloc.freezed.dart';
part 'incomes_event.dart';
part 'incomes_state.dart';

class IncomesBloc extends Bloc<IncomesEvent, IncomesState> {
  final TitheBoxService _titheBoxService;

  _LoadedState get currentState => state as _LoadedState;

  IncomesBloc(this._titheBoxService) : super(const IncomesState.loading()) {
    on<_Init>(_mapInitToState);
    on<_Refresh>(_mapRefreshToState);
    on<_SalaryTypeChanged>(_mapSalaryTypeChangedToState);
    on<_ApplyFilterChanges>(_mapApplyFilterChangesToState);
  }

  IncomesState _buildInitialState({
    SalaryType salaryType = SalaryType.monthly,
  }) {
    final isLoaded = state is _LoadedState;
    var data = _titheBoxService.getIncomesForCard();
    final totalIncome = _titheBoxService.totalIncome();

    if (!isLoaded) {
      switch (salaryType) {
        case SalaryType.daily:
          data = data.where((el) => el.frequency == SalaryType.daily).toList();
          break;
        case SalaryType.weekly:
          data = data.where((el) => el.frequency == SalaryType.weekly).toList();
          break;
        case SalaryType.monthly:
          data = data.where((el) => el.frequency == SalaryType.monthly).toList();
          break;
        case SalaryType.yearly:
          data = data.where((el) => el.frequency == SalaryType.yearly).toList();
          break;
        case SalaryType.random:
          data = data.where((el) => el.frequency == SalaryType.random).toList();
          break;
      }

      return IncomesState.loaded(
        incomes: data,
        totalIncome: totalIncome,
        salaryType: salaryType,
        tempSalaryType: salaryType,
        isRefreshing: false,
      );
    }

    switch (salaryType) {
      case SalaryType.daily:
        data = data.where((el) => el.frequency == SalaryType.daily).toList();
        break;
      case SalaryType.weekly:
        data = data.where((el) => el.frequency == SalaryType.weekly).toList();
        break;
      case SalaryType.monthly:
        data = data.where((el) => el.frequency == SalaryType.monthly).toList();
        break;
      case SalaryType.yearly:
        data = data.where((el) => el.frequency == SalaryType.yearly).toList();
        break;
      case SalaryType.random:
        data = data.where((el) => el.frequency == SalaryType.random).toList();
        break;
    }

    final s = currentState.copyWith.call(
      incomes: data,
      totalIncome: totalIncome,
      salaryType: salaryType,
      tempSalaryType: salaryType,
      isRefreshing: false,
    );

    return s;
  }

  void _mapInitToState(_Init event, Emitter<IncomesState> emit) {
    final state = _buildInitialState();
    emit(state);
  }

  Future<void> _mapRefreshToState(_Refresh event, Emitter<IncomesState> emit) async {
    emit(currentState.copyWith.call(isRefreshing: true));
    await _titheBoxService.getTransactionData().whenComplete(() {
      emit(_buildInitialState());
    });
  }

  void _mapSalaryTypeChangedToState(_SalaryTypeChanged event, Emitter<IncomesState> emit) {
    final state = currentState.copyWith.call(tempSalaryType: event.salaryType);
    emit(state);
  }

  void _mapApplyFilterChangesToState(_ApplyFilterChanges event, Emitter<IncomesState> emit) {
    final state = _buildInitialState(salaryType: currentState.tempSalaryType);
    emit(state);
  }
}
