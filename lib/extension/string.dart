extension StringExtension on String {
  String hexToJsColor() {
    final prefix = substring(0, 2);
    return "#${substring(2, 8)}$prefix";
  }
}
