import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void useBrightnessChanged(BuildContext context,
    {required bool autoDarkMode, required bool isDarkMode}) {
  late final Brightness statusbarColor;
  bool isIOS = Platform.isIOS;
  if (autoDarkMode) {
    statusbarColor = Theme.of(context).brightness ==
            (isIOS ? Brightness.light : Brightness.dark)
        ? Brightness.light
        : Brightness.dark;
  } else {
    final needDark = isIOS ? !isDarkMode : isDarkMode;
    statusbarColor = needDark ? Brightness.light : Brightness.dark;
  }
  // 设置顶栏字体颜色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarBrightness: statusbarColor,
    statusBarIconBrightness: statusbarColor,
  ));
}
