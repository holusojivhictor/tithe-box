import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tithe_box/domain/models/models.dart';

part 'result_state.freezed.dart';

@freezed
class ResultState<T> with _$ResultState<T> {
  const factory ResultState.idle() = _IdleState<T>;

  const factory ResultState.loading() = _LoadingState<T>;

  const factory ResultState.data({
    required T data,
  }) = _DataState<T>;

  const factory ResultState.done() = _DoneState<T>;

  const factory ResultState.error({
    required NetworkExceptions error,
  }) = _ErrorState<T>;
}