import 'package:permission_handler/permission_handler.dart';

class Location {
  bool? _serviceEnabled;
  bool? _permissionIsGranted;

  bool get serviceEnabled => _serviceEnabled ?? false;
  bool get permissionIsGranted => _permissionIsGranted ?? false;

  Location._init();

  static Future<Location> init() async {
    var location = Location._init();
    await location._checkService();
    await location._checkPermission();
    return location;
  }

  Future<void> _checkService() async {
    _serviceEnabled = await Permission.locationWhenInUse.serviceStatus.isEnabled;
  }

  Future<void> _checkPermission() async {
    print('Checking Android permissions');
    var status = await Permission.location.status;
    if (status.isLimited || status.isDenied || status.isRestricted) {
      if (await Permission.location.request().isGranted) {
        print('Location permission granted');
        _permissionIsGranted = true;
      } else {
        print('Location permission not granted');
        _permissionIsGranted = false;
      }
    } else {
      print('Permission already granted (previous execution?)');
      _permissionIsGranted = true;
    }
  }
}
