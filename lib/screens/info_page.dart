import 'package:flutter/material.dart';

import '../localization/app_localization.dart';
import '../localization/loc_keys.dart';

class InfoPage extends StatelessWidget {
  const InfoPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Info')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Text(
          context.trans(LocKeys.textoInfo),
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
