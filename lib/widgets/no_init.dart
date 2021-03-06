import 'package:flutter/material.dart';

import '../localization/app_localization.dart';
import '../localization/loc_keys.dart';

class NotInit extends StatelessWidget {
  const NotInit();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 16),
              child: const CircularProgressIndicator(),
            ),
            Text(context.trans(LocKeys.searchWifi)),
          ],
        ),
      ),
    );
  }
}
