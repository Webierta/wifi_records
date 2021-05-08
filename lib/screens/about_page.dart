import 'package:flutter/material.dart';
import 'package:wifi_records/routes.dart';

import '../localization/app_localization.dart';
import '../localization/loc_keys.dart';

class AboutPage extends StatelessWidget {
  const AboutPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text(
              textoAbout,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(height: 10, thickness: 2, indent: 10, endIndent: 10),
            ),
            Text(context.trans(LocKeys.textoDonativo), style: TextStyle(fontSize: 18.0)),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: ElevatedButton.icon(
                style: TextButton.styleFrom(
                  elevation: 10.0,
                  padding: EdgeInsets.all(10),
                ),
                icon: const Icon(Icons.local_cafe_rounded),
                label: const Text('Buy Me a Coffee', style: TextStyle(fontSize: 16.0)),
                onPressed: () => Navigator.of(context).pushNamed(RouteGenerator.donation),
              ),
            ),
            Text(context.trans(LocKeys.textoSoftware), style: TextStyle(fontSize: 18.0)),
            Text(context.trans(LocKeys.textoRequisitos), style: TextStyle(fontSize: 18.0)),
            Text(context.trans(LocKeys.textoLicencia), style: TextStyle(fontSize: 18.0)),
            const Text(textoLicencia2),
          ],
        ),
      ),
    );
  }
}

const String textoAbout = '''
WIFI RECORDS
Version 1.0.0
Jesús Cuerda (Webierta)
Copyleft 2021
All wrongs reserved
GitHub: Webierta/wifi_records''';

const String textoLicencia2 = '''
This file is part of WIFI RECORDS. WIFI RECORDS is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation either version 3 of the License.

WIFI RECORDS is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details. https://www.gnu.org/licenses/gpl-3.0.txt
''';
