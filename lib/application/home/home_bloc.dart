import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tithe_box/domain/services/services.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TitheBoxService _titheBoxService;

  HomeBloc(this._titheBoxService) : super(const HomeState.loading()) {
    on<_Init>(_mapInitToState);
  }

  HomeState _buildInitialState() {
    final profile = _titheBoxService.getProfile();

    return HomeState.loaded(
      firstName: profile.firstName,
    );
  }

  void _mapInitToState(_Init event, Emitter<HomeState> emit) {
    emit(_buildInitialState());
  }
}