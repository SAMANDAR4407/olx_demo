import 'package:flutter/cupertino.dart';
import 'package:olx_demo/core/car_api.dart';
import 'package:olx_demo/core/car_model.dart';

class CarProvider extends ChangeNotifier{
  final CarApi _api;

  CarProvider(this._api);

  final _list = <CarModel>[];
  var _loading = false;
  var _offset = 0;

  Future<void> loadData() async {
    if(_loading||_offset>1000) return;
    _loading = true;
    notifyListeners();
    try{
      _list.addAll(await _api.cars(offset: _offset));
      _offset+=10;
      _loading = false;
      notifyListeners();
    }catch(e){
      //
    }
  }

  List<CarModel> get list => _list;

  bool get loading => _loading;

}