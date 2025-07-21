import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void useBrightness(BuildContext context) {
  late final Brightness statusbarColor;
  statusbarColor = ThemeData.estimateBrightnessForColor(
    Theme.of(context).colorScheme.surfaceContainer,
  );
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );
  if (Platform.isAndroid || Platform.isIOS) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: statusbarColor,
        statusBarIconBrightness: statusbarColor,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
  }
}
