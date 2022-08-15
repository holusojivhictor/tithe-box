part of 'transactions_bloc.dart';

@freezed
class TransactionsState with _$TransactionsState {
  const factory TransactionsState.loading() = _LoadingState;

  const factory TransactionsState.loaded({
    required List<TransactionCardModel> transactions,
  }) = _LoadedState;
}
