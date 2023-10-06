import 'package:flutter/material.dart';

@immutable
class ExtendColors extends ThemeExtension<ExtendColors> {
  ExtendColors({required this.colorScheme}) {
    elevationBackground = ElevationOverlay.applySurfaceTint(
        colorScheme.surface, colorScheme.primary, 2);
  }

  final ColorScheme colorScheme;
  late final Color elevationBackground;

  // Color get elevationBackground {
  //   return ElevationOverlay.applySurfaceTint(
  //       colorScheme.surface, colorScheme.surfaceTint, 1.0);
  // }

  @override
  ExtendColors copyWith({ColorScheme? colorScheme}) {
    return ExtendColors(
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }

  @override
  ExtendColors lerp(ThemeExtension<ExtendColors>? other, double t) {
    // if (other is! ExtendColors) {
    //   return this;
    // }
    // return ExtendColors(
    //   colorScheme: other.colorScheme,
    // );
    return this;
  }
}
