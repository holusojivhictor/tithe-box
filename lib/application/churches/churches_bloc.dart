// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/domain/services/services.dart';

part 'churches_bloc.freezed.dart';
part 'churches_event.dart';
part 'churches_state.dart';

class ChurchesBloc extends Bloc<ChurchesEvent, ChurchesState> {
  final TitheBoxService _titheBoxService;

  _LoadedState get currentState => state as _LoadedState;

  ChurchesBloc(this._titheBoxService) : super(const ChurchesState.loading()) {
    on<_Init>(_mapInitToState);
    on<_SearchChanged>(_mapSearchChangedToState);
  }

  ChurchesState _buildInitialState({
    String? search,
  }) {
    final isLoaded = state is _LoadedState;
    var data = _titheBoxService.getChurchesForCard();

    if (!isLoaded) {
      return ChurchesState.loaded(
        churches: data,
        search: search,
      );
    }

    if (search != null && search.isNotEmpty) {
      data = data.where((el) => el.name.toLowerCase().contains(search.toLowerCase())).toList();
    }

    final s = currentState.copyWith.call(
      churches: data,
      search: search,
    );

    return s;
  }

  void _mapInitToState(_Init event, Emitter<ChurchesState> emit) {
    final state = _buildInitialState();
    emit(state);
  }

  void _mapSearchChangedToState(_SearchChanged event, Emitter<ChurchesState> emit) {
    final state = _buildInitialState(
      search: event.search,
    );
    emit(state);
  }
}
