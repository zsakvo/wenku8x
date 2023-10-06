import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

ColorScheme getColorScheme(BuildContext context) =>
    Theme.of(context).colorScheme;
