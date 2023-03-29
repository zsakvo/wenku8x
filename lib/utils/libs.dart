import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wenku8x/utils/log.dart';

initLibs() async {
  // 拷贝 libs
  var docDir = await getApplicationDocumentsDirectory();
  var libJs = await rootBundle.load("assets/reader.js");
  var libJsDest = File("${docDir.path}/reader.js");
  libJsDest.writeAsBytesSync(libJs.buffer.asUint8List());
  Log.d(libJsDest.path, "libjs");
}

initFonts() async {
  var docDir = await getApplicationDocumentsDirectory();
  const oriFontDir = 'assets/font/';
  const fontFiles = ["font.css", "serif_bold.ttf", "serif_medium.ttf"];

  for (var file in fontFiles) {
    copyAssetToFile("${oriFontDir}file", "${docDir.path}/font/$file");
  }
}

Future<File> copyAssetToFile(String assetPath, String filePath) async {
  final data = await rootBundle.load(assetPath);
  final bytes = data.buffer.asUint8List();
  return await File(filePath).writeAsBytes(bytes);
}
