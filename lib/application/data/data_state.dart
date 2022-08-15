part of 'data_bloc.dart';

@freezed
class DataState with _$DataState {
  const factory DataState.idle() = _IdleState;

  const factory DataState.loading() = _LoadingState;

  const factory DataState.data({
    required Response data,
  }) = _DataState;

  const factory DataState.error({
    required NetworkExceptions error,
  }) = _ErrorState;
}
