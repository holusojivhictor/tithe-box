// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/domain/services/services.dart';

part 'transactions_bloc.freezed.dart';
part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final TitheBoxService _titheBoxService;

  _LoadedState get currentState => state as _LoadedState;

  TransactionsBloc(this._titheBoxService) : super(const TransactionsState.loading()) {
    on<_Init>(_mapInitToState);
  }

  TransactionsState _buildInitialState() {
    final isLoaded = state is _LoadedState;
    var data = _titheBoxService.getTransactionsForCard();

    if (!isLoaded) {
      return TransactionsState.loaded(transactions: data);
    }

    final s = currentState.copyWith.call(
      transactions: data,
    );

    return s;
  }

  void _mapInitToState(_Init event, Emitter<TransactionsState> emit) {
    final state = _buildInitialState();
    emit(state);
  }
}
