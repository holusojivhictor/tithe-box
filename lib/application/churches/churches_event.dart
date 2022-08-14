part of 'churches_bloc.dart';

@freezed
class ChurchesEvent with _$ChurchesEvent {
  const factory ChurchesEvent.init() = _Init;

  const factory ChurchesEvent.searchChanged({
    required String search,
  }) = _SearchChanged;
}
