import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olx_demo/core/car_model.dart';
import '../../../core/car_api.dart';

part 'car_event.dart';
part 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final CarApi _api;

  CarBloc(this._api) : super(const CarState()) {
    on<CarEvent>((event, emit) async {
      switch (event) {
        case LoadDataEvent():
          await _onLoadDataEvent(event, emit);
          break;
        default:
          break;
      }
    });
  }

  Future<void> _onLoadDataEvent(
      LoadDataEvent event, Emitter<CarState> emit) async {
    if (state.status == EnumStatus.loading || state.offset > 1000) return;
    emit(state.copyWith(status: EnumStatus.loading));
    try {
      final list = <CarModel>[];
      list.addAll(state.list);
      list.addAll(await _api.cars(offset: state.offset));
      emit(state.copyWith(
        status: EnumStatus.success,
        offset: state.offset + 10,
        list: list,
      ));
    } catch (e) {
      emit(state.copyWith(status: EnumStatus.fail, message: "$e"));
    }
  }
}
