import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:wenku8x/app/services/path.dart';
import 'package:wenku8x/reader/helper/layout.dart';
import 'package:wenku8x/reader/models/progress.dart';

class ReaderProgressService {
  static final ReaderProgressService _instance =
      ReaderProgressService._internal();

  ProgressModel? _progress;

  ReaderProgressService._internal();

  factory ReaderProgressService() => _instance;

  void init(ProgressModel progress) {
    _progress = progress;
  }

  void update(PageLayout page) {
    if (_progress == null) {
      throw Exception('ReaderProgressService not initialized with a progress');
    }
    final paragraph = page.paragraphs.first;
    _progress = _progress!.copyWith(
      chapterId: page.chapterId,
      paragraphIndex: paragraph.paragraphIndex,
      lineIndex: paragraph.lines.first.lineIndex,
    );
    _writeProgress();
  }

  _writeProgress() async {
    if (_progress == null) {
      throw Exception('ReaderProgressService not initialized with a progress');
    }
    await _progressFile.writeAsString(jsonEncode(_progress!.toJson()));
  }

  ProgressModel? get progress => _progress;

  File get _progressFile {
    if (_progress == null) {
      throw Exception('ReaderProgressService not initialized with a progress');
    }
    return File(
      join(PathService().booksDirectory, _progress!.bookId, "progress.json"),
    );
  }

  String get chapterId {
    if (_progress == null) {
      throw Exception('ReaderProgressService not initialized with a progress');
    }
    return _progress!.chapterId;
  }

  int get paragraphIndex {
    if (_progress == null) {
      throw Exception('ReaderProgressService not initialized with a progress');
    }
    return _progress!.paragraphIndex;
  }

  int get lineIndex {
    if (_progress == null) {
      throw Exception('ReaderProgressService not initialized with a progress');
    }
    return _progress!.lineIndex;
  }
}
