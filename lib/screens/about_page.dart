import 'package:flutter/material.dart';
import 'package:wifi_records/routes.dart';

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
            const Divider(
              height: 10,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            const Text(textoDonativo, style: TextStyle(fontSize: 18.0)),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
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
            const Text(textoSoftware, style: TextStyle(fontSize: 18.0)),
            const Text(textoRequisitos, style: TextStyle(fontSize: 18.0)),
            const Text(textoLicencia),
            const Text(textoDependencias),
          ],
        ),
      ),
    );
  }
}

const String textoAbout = '''
WIFI RECORDS
Versión 1.0.0
Jesús Cuerda (Webierta)
Copyleft 2021
Todos los errores reservados
GitHub: Webierta/wifi_records
''';

const String textoDonativo = '''

Wifi Records es software libre de código abierto que ofrece una aplicación gratuita y sin publicidad.

Apoya el desarrollo de ésta y otras aplicaciones con un donativo en mi monedero de Bitcoin o vía PayPal. Gracias.''';

const String textoSoftware = '''

Software libre de código abierto sujeto a la GNU General Public License v.3, distribuido con la esperanza de que sea entretenido, pero SIN NINGUNA GARANTÍA.

Esta aplicación no extrae ni almacena ninguna información del usuario y renuncia a la publicidad y a cualquier mecanismo de seguimiento.

Software libre de spyware, malware, virus o cualquier proceso que atente contra tu dispositivo o viole tu privacidad.
''';

const String textoRequisitos = '''
REQUISITOS Y PERMISOS

Android 5.0 o superior.

La aplicación requiere la Ubicación habilitada y permisos para utilizarla. A diferencia de otras aplicaciones que utilizan la Ubicación, no requiere Google Play Services, por lo que se puede instalar en dispositivos sin Google Play.
''';

const String textoLicencia = '''
LICENCIA

Copyleft 2021, Jesús Cuerda Villanueva. All Wrongs Reserved.

Software libre de código abierto sujeto a la GNU General Public License v.3. WIFI RECORDS es software libre distribuido con la esperanza de que sea útil, pero SIN NINGUNA GARANTÍA.

This file is part of WIFI RECORDS. WIFI RECORDS is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation either version 3 of the License.

WIFI RECORDS is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details. https://www.gnu.org/licenses/gpl-3.0.txt
''';

const String textoDependencias = '''
RECONOCIMIENTOS Y DEPENDENCIAS

Aplicación desarrollada con Flutter.

Packages de Flutter y Dart: provider (MIT License, Remi Rousselet), wifi_info_flutter (BSD License, flutter.dev), connectivity (BSD License, flutter.dev), permission_handler (MIT License, Baseflow), android_intent (BSD License, flutter.dev), hive (Apache License, hivedb.dev), path_provider (BSD License, flutter.dev), flutter_local_notifications (BSD License, dexterx.dev).
''';
