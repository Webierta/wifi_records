import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  final context;
  LocationService(this.context);

  // Check if gps service is enabled or not
  Future<bool> gpsService() async {
    print('Checking Location permission');
    var _serviceEnabled = await Permission.locationWhenInUse.serviceStatus.isEnabled;
    if (!_serviceEnabled) {
      await _checkGps();
      return false;
    } else {
      print('Checking Android permissions');
      var status = await Permission.location.status;
      if (status.isLimited || status.isDenied || status.isRestricted) {
        if (await Permission.location.request().isGranted) {
          print('Location permission granted');
          return true;
        } else {
          print('Location permission not granted');
          /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Permiso de ubicación requerido.'),
            ));*/
          return false;
        }
      } else {
        print('Permission already granted (previous execution?)');
        return true;
      }
    }
  }

  // Show dialog if GPS not enabled and open settings location
  // https://dev.to/ahmedcharef/flutter-wait-user-enable-gps-permission-location-4po2
  // TODO: request location permiso
  Future _checkGps() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text('Location disabled'),
            content: const Text(
                'Open Settings and enable Location.\nPlease then run the application again.'),
            actions: <Widget>[
              TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    SystemNavigator.pop();
                  }),
              TextButton(
                child: const Text('Open'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  final intent = AndroidIntent(action: 'android.settings.LOCATION_SOURCE_SETTINGS');
                  intent.launch();
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
