import 'dart:ui';

generateColorFromString(String str) {
  int hash = str.hashCode;

  // Extract RGB components
  int r = (hash & 0xFF0000) >> 16;
  int g = (hash & 0x00FF00) >> 8;
  int b = hash & 0x0000FF;

  // Darken the colors to ensure they're suitable for light mode backgrounds
  // Map values to range 100-180 (similar to Material colors 500-700)
  r = 100 + (r % 81);
  g = 100 + (g % 81);
  b = 100 + (b % 81);

  return Color.fromARGB(255, r, g, b);
}
