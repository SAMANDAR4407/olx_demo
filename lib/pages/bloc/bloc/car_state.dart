part of 'car_bloc.dart';

@immutable
class CarState {
  final EnumStatus status;
  final List<CarModel> list;
  final int offset;
  final String message;

  const CarState(
      {this.status = EnumStatus.initial,
      this.list = const [],
      this.offset = 0,
      this.message = ""});

  CarState copyWith({
    EnumStatus? status,
    List<CarModel>? list,
    int? offset,
    String? message,
  }) {
    return CarState(
        status: status ?? this.status,
        list: list ?? this.list,
        offset: offset ?? this.offset,
        message: message ?? this.message);
  }
}

enum EnumStatus { initial, success, fail, loading }
