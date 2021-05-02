import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'models/red_wifi.dart';
import 'models/redes.dart';
import 'routes.dart';

// Sets a platform override for desktop to avoid exceptions. See
// https://flutter.dev/desktop#target-platform-override for more info.

void main() async {
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    //Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    var directory = (await getExternalStorageDirectory())!;
    Hive
      ..init(directory.path)
      ..registerAdapter(RedWifiAdapter());
    //await Hive.openBox('box');

    runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Redes())],
      child: MyApp(),
    ));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wifi Alert',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent,
        // primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(bodyText2: TextStyle(fontSize: 16.0)),
      ),
      //home: LocationPage(),
      initialRoute: RouteGenerator.home,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
