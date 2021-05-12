import 'loc_keys.dart';

const Map<LocKeys, String> langEn = {
  LocKeys.wifiStatusOn: 'Wifi network: Connected.',
  LocKeys.wifiStatusOff: 'Wifi network: Not available.',
  LocKeys.noWifi: 'No wifi connection',
  LocKeys.regNet: 'Registered networks:',
  LocKeys.noRegNet: 'No registered wifi network.',
  LocKeys.delete: 'deleted',
  LocKeys.deleteReg: 'Delete records',
  LocKeys.actionDelete: 'This action deletes all stored records.',
  LocKeys.cancel: 'Cancel',
  LocKeys.confirm: 'Confirm',
  LocKeys.nothingRemove: 'Nothing to remove.',
  LocKeys.textoInfo: '''
WIFI RECORDS

Simple app that alerts when the device connects to an unregistered Wi-Fi network while running in the background.

To register a Wi-Fi network, connect to that network and click on the <Save> icon (if it does not appear, that network is already registered).

To delete a registered network, swipe that network to the right of the screen (that does not disconnect you from that network).
''',
  LocKeys.locDisabled: 'Location disabled',
  LocKeys.locRequired:
      'Enabled location service is required.\nOpen Settings and enable Location.\nPlease then run the application again.',
  LocKeys.close: 'Close',
  LocKeys.openSettings: 'Open settings',
  LocKeys.wifiNotDetected: 'Wi-Fi connection not detected.',
  LocKeys.permitRequired: 'Location permit required.',
  LocKeys.regNetWork: 'Registered network',
  LocKeys.regNotNetWork: 'Network not registered',
  LocKeys.textoDonativo: '''
Wifi Records is free open source software that offers a free and ad-free application.

If you like Wifi Records, please consider making a donation. Thanks.''',
  LocKeys.textoSoftware: '''
Free open source software subject to the GNU General Public License v.3, distributed in the hope that it will be entertaining, but WITHOUT ANY WARRANTY.

This application does not extract or store any user information and disclaims advertising and any tracking mechanism.

Software free of spyware, malware, viruses or any process that attacks your device or violates your privacy.
  ''',
  LocKeys.textoRequisitos: '''
REQUIREMENTS AND PERMITS

Android 5.0 or higher.

The app requires Location enabled and permissions to use it. Unlike other applications that use Location, it does not require Google Play Services, so it can be installed on devices without Google Play.
''',
  LocKeys.textoLicencia: '''
LICENSE

Copyleft 2021, Jesús Cuerda Villanueva. All Wrongs Reserved.

Free open source software subject to the GNU General Public License v.3. WIFI RECORDS is free software distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY.
''',
  LocKeys.searchWifi: 'Searching for wifi connection ...',
  LocKeys.about: 'About',
  LocKeys.deleteAll: 'Delete All',
  LocKeys.exit: 'Exit',
};
