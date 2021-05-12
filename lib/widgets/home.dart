import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../localization/app_localization.dart';
import '../localization/loc_keys.dart';
import '../models/red_wifi.dart';
import '../models/redes.dart';
import 'my_appbar.dart';

class Home extends StatelessWidget {
  final Function init;
  Home(this.init);

  @override
  Widget build(BuildContext context) {
    context.watch<Redes>().getRedes();

    StatelessWidget _iconTrailing() {
      if (context.read<Redes>().connectivityWifi) {
        if (context
            .read<Redes>()
            .existeRed(context.read<Redes>().wifiName, context.read<Redes>().wifiBSSID)) {
          return const Icon(Icons.lock, color: Colors.grey);
        } else {
          return IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              context.read<Redes>().saveRed(RedWifi(
                  wifiName: context.read<Redes>().wifiName,
                  wifiBSSID: context.read<Redes>().wifiBSSID));
              init();
            },
          );
        }
      } else {
        return const Icon(Icons.warning_amber_outlined, color: Colors.redAccent);
      }
    }

    return Scaffold(
      appBar: MyAppBar(appBar: AppBar(), init: init),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      context.read<Redes>().connectivityWifi
                          ? context.trans(LocKeys.wifiStatusOn)
                          : context.trans(LocKeys.wifiStatusOff),
                      //'Wifi Status: Not available'),
                    ),
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: context.read<Redes>().connectivityWifi
                            ? const Icon(Icons.wifi, color: Colors.blue)
                            : const Icon(Icons.signal_wifi_off, color: Colors.grey),
                        title: Text(context.read<Redes>().connectivityWifi
                            ? context.watch<Redes>().wifiName
                            : context.trans(LocKeys.noWifi)),
                        subtitle: context.read<Redes>().connectivityWifi
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text('BSSID: ${context.watch<Redes>().wifiBSSID}')),
                                  FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text('IP: ${context.watch<Redes>().wifiIp}'))
                                ],
                              )
                            : null,
                        trailing: _iconTrailing(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(context.trans(LocKeys.regNet)),
                  ),
                ),
                (context.watch<Redes>().redes.length == 0)
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Text(context.trans(LocKeys.noRegNet)),
                      )
                    : Consumer<Redes>(
                        builder: (context, data, child) {
                          return Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, index) => Divider(
                                thickness: 0.5,
                                color: Colors.grey,
                                indent: 10,
                                endIndent: 10,
                              ),
                              itemCount: data.redes.length,
                              itemBuilder: (context, index) {
                                //RedWifi red = data.redes[index];
                                return Dismissible(
                                  key: Key(data.redes[index].wifiBSSID),
                                  background: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFECEFF1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        bottomLeft: Radius.circular(40),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Icon(
                                          Icons.delete_forever,
                                          size: 40,
                                          color: Color(0xFFF44336),
                                        ),
                                      ),
                                    ),
                                  ),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (direction) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            '${data.redes[index].wifiName} ${context.trans(LocKeys.delete)}'),
                                      ),
                                    );
                                    data.removeRed(data.redes[index]);
                                    if (data.redes[index].wifiBSSID ==
                                        context.read<Redes>().wifiBSSID) {
                                      init(); // solo si es la red conectada
                                    }
                                  },
                                  child: ListTile(
                                    leading: const Icon(Icons.wifi_lock),
                                    title: Text(data.redes[index].wifiName),
                                    subtitle: Text(data.redes[index].wifiBSSID),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
