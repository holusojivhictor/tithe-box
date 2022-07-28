import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/domain/services/services.dart';

part 'data_bloc.freezed.dart';
part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final TitheBoxService _titheBoxService;
  final IncomesBloc _incomesBloc;

  DataBloc(this._titheBoxService, this._incomesBloc) : super(const DataState.idle()) {
    on<_RecordIncome>((e, emit) async {
      emit(const DataState.loading());
      try {
        final response = await _titheBoxService.recordIncome(e.businessName, e.incomeAmount, e.description, e.frequency);
        await _titheBoxService.getIncomeData();
        _incomesBloc.add(const IncomesEvent.init());
        emit(DataState.data(data: response));
      } catch (e) {
        emit(DataState.error(error: NetworkExceptions.getDioException(e)));
      }
    });
  }
}