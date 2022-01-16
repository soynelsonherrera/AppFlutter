import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _precio = prefs.getDouble('ff_precio') ?? _precio;
    _list = prefs.getStringList('ff_list')?.map(double.parse)?.toList() ?? [];
    _Total = prefs.getDouble('ff_Total') ?? _Total;
  }

  SharedPreferences prefs;

  List<String> todolist = [];

  double _precio = 0.0;
  double get precio => _precio;
  set precio(double _value) {
    _precio = _value;
    prefs.setDouble('ff_precio', _value);
  }

  List<double> _list = [];
  List<double> get list => _list;
  set list(List<double> _value) {
    _list = _value;
    prefs.setStringList('ff_list', _value.map((x) => x.toString()).toList());
  }

  void addToList(double _value) {
    _list.add(_value);
    prefs.setStringList('ff_list', _list.map((x) => x.toString()).toList());
  }

  void removeFromList(double _value) {
    _list.remove(_value);
    prefs.setStringList('ff_list', _list.map((x) => x.toString()).toList());
  }

  double _Total = 0.0;
  double get Total => _Total;
  set Total(double _value) {
    _Total = _value;
    prefs.setDouble('ff_Total', _value);
  }
}

LatLng _latLngFromString(String val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
