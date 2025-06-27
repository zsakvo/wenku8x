import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'text.dart';

/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade package to version 8.1.0.
///
/// Use in [MaterialApp] like this:
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
///     :
/// );
abstract final class AppTheme {
  // The defined light theme.
  static ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.greys,
    subThemesData: const FlexSubThemesData(
      scaffoldBackgroundBaseColor: FlexScaffoldBaseColor.surfaceContainer,
      bottomNavigationBarBackgroundSchemeColor: SchemeColor.surfaceContainer,
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      splashType: FlexSplashType.inkSplash,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    textTheme: textTheme,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
  // The defined dark theme.
  static ThemeData dark = FlexThemeData.dark(
    scheme: FlexScheme.greys,
    subThemesData: const FlexSubThemesData(
      scaffoldBackgroundBaseColor: FlexScaffoldBaseColor.surfaceContainer,
      bottomNavigationBarBackgroundSchemeColor: SchemeColor.surfaceContainer,
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      splashType: FlexSplashType.inkSplash,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    textTheme: textTheme,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
