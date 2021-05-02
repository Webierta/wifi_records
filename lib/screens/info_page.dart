import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Info')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Text(
          textoInfo,
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}

const String textoInfo = '''
WIFI RECORDS

Aplicación simple que alerta cuando el dispositivo se conecta a una red Wi-Fi no registrada mientras se ejecuta en segundo plano.

La notificación principal aparece como un icono en la barra de estado.

Otras notificaciones secundarias aparecen en forma de un cuadro de diálogo flotante, un sonido y una breve vibración. Normalmente cualquier dispositivo permite personalizar estas notificaciones secundarias para habilitarlas o desactivarlas.

Para registrar una red wifi, conéctate a esa red y pulsa sobre el icono de <Guardar> (si no aparece es que esa red ya está registrada).

Para eliminar una red registrada, desliza esa red hacia la derecha de la pantalla (eso no te desconecta a esa red). 
''';
