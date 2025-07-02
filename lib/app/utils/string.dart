String formatNumberToUnitString(int number, {String unit = ""}) {
  if (number < 1000) {
    return number.toString();
  } else if (number < 10000) {
    return '${(number / 1000).toStringAsFixed(1)}$unit';
  } else {
    return '${(number / 10000).toStringAsFixed(1)}万';
  }
}
