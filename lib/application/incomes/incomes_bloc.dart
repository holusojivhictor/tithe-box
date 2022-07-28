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
    on<_SalaryTypeChanged>(_mapSalaryTypeChangedToState);
    on<_ApplyFilterChanges>(_mapApplyFilterChangesToState);
  }

  IncomesState _buildInitialState({
    SalaryType salaryType = SalaryType.weekly,
  }) {
    final isLoaded = state is _LoadedState;
    var data = _titheBoxService.getIncomesForCard();

    if (!isLoaded) {
      return IncomesState.loaded(
        incomes: data,
        salaryType: salaryType,
        tempSalaryType: salaryType,
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
      salaryType: salaryType,
      tempSalaryType: salaryType,
    );

    return s;
  }

  void _mapInitToState(_Init event, Emitter<IncomesState> emit) {
    final state = _buildInitialState();
    emit(state);
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