import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/red_wifi.dart';
import '../models/redes.dart';
import 'my_appbar.dart';

class Home extends StatelessWidget {
  final Function init;
  Home(this.init);

  @override
  Widget build(BuildContext context) {
    context.watch<Redes>().getRedes();
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
                    child: Text(context.read<Redes>().connectivityWifi == true
                        ? 'Wifi Status:  Connected'
                        : 'Wifi Status: Not available'),
                  ),
                ),
                if (context.read<Redes>().connectivityWifi)
                  Card(
                    margin: const EdgeInsets.only(bottom: 30.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.wifi, color: Colors.blue),
                          title: Text(context.watch<Redes>().wifiName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('BSSID: ${context.watch<Redes>().wifiBSSID}'),
                              Text('IP: ${context.watch<Redes>().wifiIp}')
                            ],
                          ),
                          trailing: (context.read<Redes>().existeRed(
                                  context.read<Redes>().wifiName, context.read<Redes>().wifiBSSID))
                              ? const Icon(Icons.lock)
                              : IconButton(
                                  icon: const Icon(Icons.save),
                                  onPressed: () {
                                    context.read<Redes>().saveRed(RedWifi(
                                        wifiName: context.read<Redes>().wifiName,
                                        wifiBSSID: context.read<Redes>().wifiBSSID));
                                    init();
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Redes registradas:'),
                ),
                (context.watch<Redes>().redes.length == 0)
                    ? const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Ninguna red wifi registrada.'),
                        ),
                      )
                    : Consumer<Redes>(
                        builder: (context, data, child) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: data.redes.length,
                              itemBuilder: (context, index) {
                                //RedWifi red = data.redes[index];
                                return Dismissible(
                                  key: Key(data.redes[index].wifiBSSID),
                                  background: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFECEFF1), //blueGrey[50] 0XFFCFD8DC = [100]
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
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text('${data.redes[index].wifiName} delete')));
                                    data.removeRed(data.redes[index]);
                                    init();
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
