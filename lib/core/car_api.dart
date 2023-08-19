import 'package:dio/dio.dart';
import 'package:olx_demo/core/car_model.dart';

class CarApi{

  final _api = Dio(BaseOptions(baseUrl: "https://www.olx.uz/api/v1/"));

  Future<List<CarModel>> cars({
  int offset = 0,
  int limit = 10
  }) async {

    final response = await _api.get(
      "offers/?offset=$offset&limit=$limit&category_id=108",
    );

    return (response.data['data'] as List).
        map((e) => CarModel.fromJson(e)).toList();
  }
}