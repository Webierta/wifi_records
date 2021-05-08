import 'loc_keys.dart';

const Map<LocKeys, String> langEs = {
  LocKeys.wifiStatusOn: 'Red Wifi: Conectada.',
  LocKeys.wifiStatusOff: 'Red Wifi: No disponible.',
  LocKeys.noWifi: 'Sin conexión wifi.',
  LocKeys.regNet: 'Redes registradas:',
  LocKeys.noRegNet: 'Ninguna red wifi registrada.',
  LocKeys.delete: 'eliminado',
  LocKeys.deleteReg: 'Eliminar registros',
  LocKeys.actionDelete: 'Esta acción elimina todos los registros almacenados.',
  LocKeys.cancel: 'Cancelar',
  LocKeys.confirm: 'Confirmar',
  LocKeys.nothingRemove: 'Nada que eliminar.',
  LocKeys.textoInfo: '''
WIFI RECORDS

Aplicación simple que alerta cuando el dispositivo se conecta a una red Wi-Fi no registrada mientras se ejecuta en segundo plano.

La notificación principal aparece como un icono en la barra de estado.

Otras notificaciones secundarias aparecen en forma de un cuadro de diálogo flotante, un sonido y una breve vibración. Normalmente cualquier dispositivo permite personalizar estas notificaciones secundarias para habilitarlas o desactivarlas.

Para registrar una red wifi, conéctate a esa red y pulsa sobre el icono de <Guardar> (si no aparece es que esa red ya está registrada).

Para eliminar una red registrada, desliza esa red hacia la derecha de la pantalla (eso no te desconecta a esa red).
''',
  LocKeys.locDisabled: 'Ubicación deshabilitada',
  LocKeys.locRequired:
      'Se requiere el servicio de Ubicación habilitado.\nAbre Ajustes y habilita Ubicación.\nPor favor, después ejecuta otra vez la aplicación.',
  LocKeys.close: 'Cerrar',
  LocKeys.openSettings: 'Abrir Ajustes',
  LocKeys.wifiNotDetected: 'Conexión Wifi no detectada.',
  LocKeys.permitRequired: 'Requerido permiso de Ubicación.',
  LocKeys.regNetWork: 'Red registrada',
  LocKeys.regNotNetWork: 'Red registrada',
  LocKeys.textoDonativo: '''
Wifi Records es software libre de código abierto que ofrece una aplicación gratuita y sin publicidad.

Si te gusta Wifi Records, por favor, considera hacer una donación. Gracias.''',
  LocKeys.textoSoftware: '''
Software libre de código abierto sujeto a la GNU General Public License v.3, distribuido con la esperanza de que sea entretenido, pero SIN NINGUNA GARANTÍA.

Esta aplicación no extrae ni almacena ninguna información del usuario y renuncia a la publicidad y a cualquier mecanismo de seguimiento.

Software libre de spyware, malware, virus o cualquier proceso que atente contra tu dispositivo o viole tu privacidad.
''',
  LocKeys.textoRequisitos: '''
REQUISITOS Y PERMISOS

Android 5.0 o superior.

La aplicación requiere la Ubicación habilitada y permisos para utilizarla. A diferencia de otras aplicaciones que utilizan la Ubicación, no requiere Google Play Services, por lo que se puede instalar en dispositivos sin Google Play.
''',
  LocKeys.textoLicencia: '''
LICENCIA

Copyleft 2021, Jesús Cuerda Villanueva. All Wrongs Reserved.

Software libre de código abierto sujeto a la GNU General Public License v.3. WIFI RECORDS es software libre distribuido con la esperanza de que sea útil, pero SIN NINGUNA GARANTÍA.
''',
  LocKeys.searchWifi: 'Buscando conexión wifi...',
  LocKeys.about: 'Acerca de',
  LocKeys.deleteAll: 'Eliminar Todo',
  LocKeys.exit: 'Salir',
};
