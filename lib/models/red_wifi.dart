import 'package:hive/hive.dart';

part 'red_wifi.g.dart';

@HiveType(typeId: 1)
class RedWifi {
  @HiveField(0)
  String wifiName;

  @HiveField(1)
  String wifiBSSID;

  RedWifi({required this.wifiName, required this.wifiBSSID});
}
