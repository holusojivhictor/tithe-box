// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/domain/services/services.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TitheBoxService _titheBoxService;

  _LoadedState get currentState => state as _LoadedState;

  HomeBloc(this._titheBoxService) : super(const HomeState.loading()) {
    on<_Init>(_mapInitToState);
    on<_HomeContentTypeChanged>(_mapContentTypeChanged);
    on<_ApplyFilterChanges>(_mapApplyFilterChangesToState);
  }

  HomeState _buildInitialState({
    HomeContentType contentType = HomeContentType.all,
  }) {
    final isLoaded = state is _LoadedState;
    final profile = _titheBoxService.getProfile();

    if (!isLoaded) {
      return HomeState.loaded(
        firstName: profile.firstName,
        contentType: contentType,
        tempContentType: contentType,
      );
    }

    final s = currentState.copyWith.call(
      firstName: profile.firstName,
      contentType: contentType,
      tempContentType: contentType,
    );
    return s;
  }

  void _mapInitToState(_Init event, Emitter<HomeState> emit) {
    emit(_buildInitialState());
  }

  void _mapContentTypeChanged(_HomeContentTypeChanged event, Emitter<HomeState> emit) {
    final state = currentState.copyWith.call(tempContentType: event.contentType);
    emit(state);
  }

  void _mapApplyFilterChangesToState(_ApplyFilterChanges event, Emitter<HomeState> emit) {
    final state = _buildInitialState(contentType: currentState.tempContentType);
    emit(state);
  }
}