import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wenku8x/utils/log.dart';

initLibs() async {
  // 拷贝 libs
  var docDir = await getApplicationDocumentsDirectory();
  var libs = await rootBundle.load("assets/libs.zip");
  var libsZip = File("${docDir.path}/libs.zip");
  libsZip.writeAsBytesSync(libs.buffer.asUint8List());
  await _unzip(libsZip, docDir);
  libsZip.delete();
  final Directory booksDir = Directory("${docDir.path}/books");
  if (!booksDir.existsSync()) booksDir.createSync();
  docDir.listSync().forEach((element) {
    Log.d(element.path);
  });
}

_unzip(File bookFile, Directory unzip) async {
  final inputStream = InputFileStream(bookFile.path);
  final Archive archive = ZipDecoder().decodeBuffer(inputStream);
  extractArchiveToDisk(archive, unzip.path);
}
