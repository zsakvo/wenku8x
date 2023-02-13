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
