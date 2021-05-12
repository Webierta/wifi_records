import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../localization/app_localization.dart';
import '../localization/loc_keys.dart';
import '../models/redes.dart';
import '../routes.dart';

enum Item { info, about, deleteAll, exit }

class Action {
  final Item id;
  final String title;
  final IconData icon;
  const Action({required this.id, required this.title, required this.icon});
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final Function init;
  const MyAppBar({required this.appBar, required this.init});

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);

  @override
  Widget build(BuildContext context) {
    var actions = <Action>[
      Action(id: Item.info, title: 'Info', icon: Icons.info_outline),
      Action(id: Item.about, title: context.trans(LocKeys.about), icon: Icons.code),
      Action(
          id: Item.deleteAll, title: context.trans(LocKeys.deleteAll), icon: Icons.delete_forever),
      Action(id: Item.exit, title: context.trans(LocKeys.exit), icon: Icons.exit_to_app_outlined),
    ];

    Future<bool> _confirmDelete() async {
      return (await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text(context.trans(LocKeys.deleteReg)),
                content: Text(context.trans(LocKeys.actionDelete)),
                actions: <Widget>[
                  TextButton(
                    child: Text(context.trans(LocKeys.cancel)),
                    onPressed: () => Navigator.of(dialogContext).pop(false),
                  ),
                  TextButton(
                    child: Text(context.trans(LocKeys.confirm)),
                    onPressed: () => Navigator.of(dialogContext).pop(true),
                  ),
                ],
              );
            },
          )) ??
          false;
    }

    Future<void> _selectAction(Action action) async {
      switch (action.id) {
        case Item.info:
          await Navigator.of(context).pushNamed(RouteGenerator.info);
          break;
        case Item.about:
          await Navigator.of(context).pushNamed(RouteGenerator.about);
          break;
        case Item.deleteAll:
          if (context.read<Redes>().isNotEmpty()) {
            var confirm = await _confirmDelete();
            if (confirm == true) {
              context.read<Redes>().deleteAll();
              init();
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(context.trans(LocKeys.nothingRemove)),
            ));
          }
          break;
        case Item.exit:
          await SystemNavigator.pop();
          break;
        /*default:
          print('DEFAULT?');
          break;*/
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
