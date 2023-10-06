extension IntExtension on int {
  bool toBool() => this == 1;

  int autoToDarkTone(bool isDarkTheme) {
    if (!isDarkTheme) return this;
    switch (this) {
      case 10:
        return 99;
      case 20:
        return 95;
      case 25:
        return 90;
      case 30:
        return 90;
      case 40:
        return 80;
      case 50:
        return 60;
      case 60:
        return 50;
      case 70:
        return 40;
      case 80:
        return 40;
      case 90:
        return 30;
      case 95:
        return 20;
      case 98:
        return 10;
      case 99:
        return 10;
      case 100:
        return 20;
      default:
        return this;
    }
  }
}
