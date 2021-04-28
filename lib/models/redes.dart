import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'red_wifi.dart';

// https://medium.com/flutter-community/storing-local-data-with-hive-and-provider-in-flutter-a49b6bdea75a
class Redes with ChangeNotifier {
  // Connection Status
  bool _connectivityWifi = false;
  get connectivityWifi => _connectivityWifi;
  set connectivityWifi(value) {
    _connectivityWifi = value;
    notifyListeners();
  }

  // Settings Android
  String _iconStatusBar = '@mipmap/wifi_star';
  get iconStatusBar => _iconStatusBar;
  set iconStatusBar(value) {
    _iconStatusBar = value;
    notifyListeners();
  }

  // obtiene y actualiza la lista de redes almacenadas
  static const _redesBox = 'box';
  List _redesWifi = <RedWifi>[];
  get redes => _redesWifi;
  getRedes() async {
    final box = await Hive.openBox<RedWifi>(_redesBox);
    _redesWifi = box.values.toList();
    notifyListeners();
  }

  // getters y setters de valores de cada red
  String _wifiName = 'Unknown';
  get wifiName => _wifiName;
  set wifiName(value) {
    _wifiName = value;
    notifyListeners();
  }

  String _wifiBSSID = 'Unknown';
  get wifiBSSID => _wifiBSSID;
  set wifiBSSID(value) {
    _wifiBSSID = value;
    notifyListeners();
  }

  String _wifiIp = 'Unknown';
  get wifiIp => _wifiIp;
  set wifiIp(value) {
    _wifiIp = value;
    notifyListeners();
  }

  //  acciones de guardar, eliminar y actualizar red en el almacén
  //  y después actualiza la lista de redes guardadas
  void saveRed(RedWifi red) async {
    if (!existeRed(red)) {
      final box = Hive.box<RedWifi>(_redesBox);
      //var box = await Hive.openBox<RedWifi>(_redesBox);
      box.put(red.wifiBSSID, red); //box.add(red);
      getRedes();
      notifyListeners();
    }
  }

  // comprueba si una red está almacenada
  bool existeRed(RedWifi newRed) {
    getRedes();
    for (var red in _redesWifi) {
      if (red.wifiName == newRed.wifiName && red.wifiBSSID == newRed.wifiBSSID) {
        return true;
      }
    }
    return false;
  }

  void removeRed(RedWifi red) {
    final box = Hive.box<RedWifi>(_redesBox);
    box.delete(red.wifiBSSID);
    getRedes(); // ??
    notifyListeners();
  }

  updateRed(RedWifi red) {
    final box = Hive.box<RedWifi>(_redesBox);
    box.put(red.wifiBSSID, red); // box.put('key', newValue)
    getRedes();
    notifyListeners();
  }

  // elimina el archivo del almacén
  deleteAll() {
    final box = Hive.box<RedWifi>(_redesBox);
    box.deleteFromDisk();
    getRedes();
    notifyListeners();
  }
}
