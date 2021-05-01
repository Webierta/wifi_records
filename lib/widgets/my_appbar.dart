import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../models/redes.dart';

class Action {
  final String title;
  final IconData icon;
  const Action({required this.title, required this.icon});
}

const titleInfo = 'Info';
const titleAbout = 'About';
const titleDelete = 'Delete all';
const titleSalir = 'Salir';

const actions = <Action>[
  Action(title: titleInfo, icon: Icons.info_outline),
  Action(title: titleAbout, icon: Icons.code),
  Action(title: titleDelete, icon: Icons.delete_forever),
  Action(title: titleSalir, icon: Icons.exit_to_app_outlined),
];

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final Function init;
  const MyAppBar({required this.appBar, required this.init});

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);

  @override
  Widget build(BuildContext context) {
    void _selectAction(Action action) {
      switch (action.title) {
        case titleInfo:
          print('INFO');
          break;
        case titleAbout:
          print('ABOUT');
          break;
        case titleDelete:
          // TODO: dialogo de confirmar eliminar todas las redes ?
          //TODO: no hacer nada si redes está vacía
          context.read<Redes>().deleteAll();
          init();
          break;
        case titleSalir:
          SystemNavigator.pop();
          break;
        default:
          print('DEFAULT');
          break;
      }
    }

    return AppBar(
      title: const Text('Wifi Records'),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () async => init(),
        ),
        PopupMenuButton<Action>(
          onSelected: _selectAction,
          elevation: 6,
          itemBuilder: (BuildContext context) {
            return actions.map((Action action) {
              return PopupMenuItem<Action>(
                value: action,
                child: Row(
                  children: [
                    Icon(action.icon),
                    SizedBox(width: 10),
                    Text(action.title),
                  ],
                ),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}
