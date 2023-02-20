import 'package:flutter/material.dart';

class Util {
  static getCover(String aid) {
    int ia = int.parse(aid);
    return "https://img.wenku8.com/image/${ia ~/ 1000}/$aid/${aid}s.jpg";
  }

  static getJsColor(Color color) {
    final colorHex = color.value.toRadixString(16);
    final prefix = colorHex.substring(0, 2);
    return colorHex.replaceAll(prefix, "") + prefix;
  }
}
