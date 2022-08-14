part of 'churches_bloc.dart';

@freezed
class ChurchesState with _$ChurchesState {
  const factory ChurchesState.loading() = _LoadingState;

  const factory ChurchesState.loaded({
    required List<ChurchCardModel> churches,
    String? search,
  }) = _LoadedState;
}
