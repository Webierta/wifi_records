import 'dart:async';

import 'package:android_intent/android_intent.dart';
import 'package:connectivity/connectivity.dart' show Connectivity, ConnectivityResult;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

import '../models/redes.dart';
import '../utils/local_notification.dart';
import '../utils/location_service.dart';
import '../widgets/home.dart';
import '../widgets/no_init.dart';

// ver wifi_info_flutter: https://pub.dev/packages/wifi_info_flutter/example
// https://stackoverflow.com/questions/62378654/flutter-connectivity-package-android-permissions
class LocationPage extends StatefulWidget {
  LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final WifiInfo _wifiInfo = WifiInfo();
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivityStream;
  LocalNotification? localNotification;

  @override
  void initState() {
    super.initState();
    _connectivityStream = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _init();
      _updateConnectionStatus(result);
    });
  }

  @override
  void dispose() {
    print('dispose');
    _connectivityStream.cancel();
    super.dispose();
  }

  Future<void> _dialogoLocation() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text('Location disabled'),
            content: const Text('Enabled location service required.\n'
                'Open Settings and enable Location.\n'
                'Please then run the application again.'),
            actions: <Widget>[
              TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    SystemNavigator.pop();
                  }),
              TextButton(
                child: const Text('Open Settings'),
                onPressed: () {
                  Navigator.of(context).pop();
                  AndroidIntent(action: 'android.settings.LOCATION_SOURCE_SETTINGS').launch();
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _init() async {
    var location = await Location.init();
    print('INIT');
    if (!location.serviceEnabled) {
      print('serviceEnabled != true');
      //TODO: posible retorno del valor pulsado y permitir tap back para regresar a la app
      // Future<bool>
      // return (await showDialog<bool>
      //  onPressed: Navigator.of(context).pop(false);
      await _dialogoLocation();
    }
    if (location.serviceEnabled && location.permissionIsGranted) {
      print('serviceEnabled == true && permissionIsGranted == true');
      var result = await _connectivity.checkConnectivity();
      //if (result != ConnectivityResult.none) {
      context.read<Redes>().connectivityDone = true;
      //}
      if (result == ConnectivityResult.wifi) {
        context.read<Redes>().connectivityWifi = true;
        await _updateConnectionStatus(result);
      } else {
        context.read<Redes>().connectivityWifi = false;
        await localNotification?.cancelNotification();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Conexión wifi no detectada.'),
        ));
      }
    } else {
      print('NO serviceEnabled == true && permissionIsGranted == true');
      await localNotification?.cancelNotification();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Permiso de ubicación requerido.'),
      ));
      context.read<Redes>().connectivityDone = false;
    }
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    print('_updateConnectionStatus');
    String? _wName;
    String? _wBSSID;
    String? _wIp;
    try {
      _wName = await _wifiInfo.getWifiName();
      _wBSSID = await _wifiInfo.getWifiBSSID();
      _wIp = await _wifiInfo.getWifiIP();
    } catch (e) {
      context.read<Redes>().connectivityWifi = false;
      print(e.toString());
    }
    if (_wName != null && _wBSSID != null && _wIp != null) {
      context.read<Redes>().wifiName = _wName;
      context.read<Redes>().wifiBSSID = _wBSSID;
      context.read<Redes>().wifiIp = _wIp;
      //if (_checkExiste(_wName, _wBSSID)) {
      if (context.read<Redes>().existeRed(_wName, _wBSSID)) {
        context.read<Redes>().iconStatusBar = '@mipmap/wifi_star';
        localNotification = LocalNotification(context.read<Redes>().iconStatusBar);
        localNotification?.notification(_wName, 'Red registrada');
      } else {
        context.read<Redes>().iconStatusBar = '@mipmap/wifi_alert';
        localNotification = LocalNotification(context.read<Redes>().iconStatusBar);
        localNotification?.notification(_wName, 'Red no registrada');
      }
    } else {
      context.read<Redes>().connectivityWifi = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<Redes>().getRedes();
    return Scaffold(
      body: context.read<Redes>().connectivityDone == true ? Home(_init) : NotInit(),
    );
  }
}
