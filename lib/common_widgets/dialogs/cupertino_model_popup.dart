import 'dart:math';

import 'package:flutter/cupertino.dart';

void showAppDialog(Widget child, context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => Container(
      height: max(250,MediaQuery.of(context).size.height/3),
      padding: const EdgeInsets.only(top: 6.0),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: SafeArea(
        top: false,
        child: child,
      ),
    ),
  );
}
