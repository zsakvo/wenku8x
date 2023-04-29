import 'package:flutter/material.dart';
import 'package:wenku8x/utils/log.dart';

class Util {
  static getCover(String aid) {
    int ia = int.parse(aid);
    return "https://img.wenku8.com/image/${ia ~/ 1000}/$aid/${aid}s.jpg";
  }

  static getJsColor(Color color) {
    final colorHex = color.value.toRadixString(16);
    String firstTwoChars = colorHex.substring(0, 2);
    String restOfString = colorHex.substring(2);
    return restOfString + firstTwoChars;
  }
}
