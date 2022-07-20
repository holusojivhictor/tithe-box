part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loading() = _LoadingState;

  const factory HomeState.loaded({
    required String firstName,
    required HomeContentType contentType,
    required HomeContentType tempContentType,
  }) = _LoadedState;
}