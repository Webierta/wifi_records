import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart' show Connectivity, ConnectivityResult;
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

import '../models/red_wifi.dart';
import '../models/redes.dart';
import '../utils/location_service.dart';
import '../utils/local_notification.dart';

// ver wifi_info_flutter: https://pub.dev/packages/wifi_info_flutter/example
// https://stackoverflow.com/questions/62378654/flutter-connectivity-package-android-permissions
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  _init() async {
    bool locationService = await LocationService(context).gpsService();
    if (locationService) {
      var result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.wifi) {
        context.read<Redes>().connectivityWifi = true;
        _updateConnectionStatus(result);
      } else {
        context.read<Redes>().connectivityWifi = false;
        localNotification?.cancelNotification();
      }
    } else {
      localNotification?.cancelNotification();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Permiso de ubicación requerido.'),
      ));
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
      if (_checkExiste(_wName, _wBSSID)) {
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

  bool _checkExiste(String name, String bssid) {
    var redes = context.read<Redes>().redes;
    for (var red in redes) {
      if (red.wifiName == name && red.wifiBSSID == bssid) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    context.watch<Redes>().getRedes();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wifi SSID'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _init(),
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              // TODO: dialogo de confirmar eliminar todas las redes ?
              context.read<Redes>().deleteAll();
              _init();
            },
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(context.read<Redes>().connectivityWifi == true
                        ? 'Wifi Status:  Connected'
                        : 'Wifi Status: Not available'),
                  ),
                ),
                if (context.read<Redes>().connectivityWifi)
                  Card(
                    margin: const EdgeInsets.only(bottom: 30.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.wifi, color: Colors.blue),
                          title: Text(context.watch<Redes>().wifiName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('BSSID: ${context.watch<Redes>().wifiBSSID}'),
                              Text('IP: ${context.watch<Redes>().wifiIp}')
                            ],
                          ),
                          trailing: _checkExiste(
                                  context.read<Redes>().wifiName, context.read<Redes>().wifiBSSID)
                              ? const Icon(Icons.lock)
                              : IconButton(
                                  icon: const Icon(Icons.save),
                                  onPressed: () {
                                    context.read<Redes>().saveRed(RedWifi(
                                        wifiName: context.read<Redes>().wifiName,
                                        wifiBSSID: context.read<Redes>().wifiBSSID));
                                    _init(); //_gpsService();
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Redes registradas:'),
                ),
                (context.watch<Redes>().redes.length == 0)
                    ? const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Ninguna red wifi registrada.'),
                        ),
                      )
                    : Consumer<Redes>(
                        builder: (context, data, child) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: data.redes.length,
                              itemBuilder: (context, index) {
                                //RedWifi red = data.redes[index];
                                return Dismissible(
                                  key: Key(data.redes[index].wifiBSSID),
                                  //background: Container(color: Colors.redAccent),
                                  background: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFECEFF1), //blueGrey[50] 0XFFCFD8DC = [100]
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          bottomLeft: Radius.circular(40),
                                        ),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Icon(
                                            Icons.delete_forever,
                                            size: 40,
                                            color: Color(0xFFF44336),
                                          ),
                                        ),
                                      )),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (direction) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text('${data.redes[index].wifiName} delete')));
                                    data.removeRed(data.redes[index]);
                                    _init(); //_gpsService();
                                  },
                                  child: ListTile(
                                    leading: const Icon(Icons.wifi_lock),
                                    title: Text(data.redes[index].wifiName),
                                    subtitle: Text(data.redes[index].wifiBSSID),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
