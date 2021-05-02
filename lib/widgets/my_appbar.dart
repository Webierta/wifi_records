import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../models/redes.dart';
import '../routes.dart';

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
    Future<bool> _confirmDelete() async {
      return (await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text('Eliminar registros'),
                content: const Text('Esta acción elimina todos los registros almacenados.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancelar'),
                    onPressed: () => Navigator.of(dialogContext).pop(false),
                  ),
                  TextButton(
                    child: const Text('Confirmar'),
                    onPressed: () => Navigator.of(dialogContext).pop(true),
                  ),
                ],
              );
            },
          )) ??
          false;
    }

    Future<void> _selectAction(Action action) async {
      switch (action.title) {
        case titleInfo:
          await Navigator.of(context).pushNamed(RouteGenerator.info);
          break;
        case titleAbout:
          await Navigator.of(context).pushNamed(RouteGenerator.about);
          break;
        case titleDelete:
          if (context.read<Redes>().isNotEmpty()) {
            var confirmar = await _confirmDelete();
            if (confirmar == true) {
              context.read<Redes>().deleteAll();
              init();
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Nada que eliminar.'),
            ));
          }
          break;
        case titleSalir:
          await SystemNavigator.pop();
          break;
        default:
          print('DEFAULT?');
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
                child: Column(children: [
                  Row(children: [
                    Icon(action.icon),
                    const SizedBox(width: 10),
                    Text(action.title),
                  ]),
                  if (actions.indexOf(action) == 1 || actions.indexOf(action) == 2)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: PopupMenuDivider(height: 20),
                    ),
                ]),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}
