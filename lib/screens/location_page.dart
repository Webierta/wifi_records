import 'dart:async';

import 'package:android_intent/android_intent.dart';
import 'package:connectivity/connectivity.dart' show Connectivity, ConnectivityResult;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

import '../localization/app_localization.dart';
import '../localization/loc_keys.dart';
import '../models/redes.dart';
import '../utils/local_notification.dart';
import '../utils/location_service.dart';
import '../widgets/home.dart';
import '../widgets/no_init.dart';

// https://pub.dev/packages/wifi_info_flutter/example
// https://stackoverflow.com/questions/62378654/flutter-connectivity-package-android-permissions
class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

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
    _connectivityStream.cancel();
    localNotification?.cancelNotification();
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
            title: Text(context.trans(LocKeys.locDisabled)),
            content: Text(context.trans(LocKeys.locRequired)),
            actions: <Widget>[
              TextButton(
                  child: Text(context.trans(LocKeys.close)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    SystemNavigator.pop();
                  }),
              TextButton(
                child: Text(context.trans(LocKeys.openSettings)),
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
    if (!location.serviceEnabled) {
      await _dialogoLocation();
    }
    if (location.serviceEnabled && location.permissionIsGranted) {
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
          content: Text(context.trans(LocKeys.wifiNotDetected)),
        ));
      }
    } else {
      await localNotification?.cancelNotification();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(context.trans(LocKeys.permitRequired)),
      ));
      context.read<Redes>().connectivityDone = false;
    }
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
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
      if (context.read<Redes>().existeRed(_wName, _wBSSID)) {
        context.read<Redes>().iconStatusBar = '@mipmap/wifi_star';
        localNotification = LocalNotification(context.read<Redes>().iconStatusBar);
        localNotification?.notification(
            title: _wName, msg: context.trans(LocKeys.regNetWork), sound: false);
      } else {
        context.read<Redes>().iconStatusBar = '@mipmap/wifi_alert';
        localNotification = LocalNotification(context.read<Redes>().iconStatusBar);
        localNotification?.notification(
            title: _wName, msg: context.trans(LocKeys.regNotNetWork), sound: true);
      }
    } else {
      context.read<Redes>().connectivityWifi = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<Redes>().getRedes();
    return Scaffold(
      body: context.read<Redes>().connectivityDone == true ? Home(_init) : const NotInit(),
    );
  }
}
