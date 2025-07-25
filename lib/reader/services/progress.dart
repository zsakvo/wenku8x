import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
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

  int getPage(List<PageLayout> pages) {
    if (_progress == null) {
      throw Exception('ReaderProgressService not initialized with a progress');
    }
    // Use binary search if paragraphs are ordered, otherwise optimize the linear search
    final targetParagraphIndex = _progress!.paragraphIndex;
    final targetLineIndex = _progress!.lineIndex;

    // First, try to find the page based on the chapter ID
    final targetChapterId = _progress!.chapterId;
    final chapterPages = pages
        .where((page) => page.chapterId == targetChapterId)
        .toList();

    if (chapterPages.isNotEmpty) {
      // If we have pages from the target chapter, focus our search there first
      for (var i = 0; i < chapterPages.length; i++) {
        final page = chapterPages[i];
        // Check if this page contains paragraphs with indices >= target
        if (page.paragraphs.isNotEmpty &&
            page.paragraphs.first.paragraphIndex <= targetParagraphIndex &&
            (i == chapterPages.length - 1 ||
                chapterPages[i + 1].paragraphs.first.paragraphIndex >
                    targetParagraphIndex)) {
          final paragraph = page.paragraphs.firstWhereOrNull(
            (p) => p.paragraphIndex == targetParagraphIndex,
          );

          if (paragraph != null) {
            final line = paragraph.lines.firstWhereOrNull(
              (l) => l.lineIndex == targetLineIndex,
            );

            if (line != null) {
              return pages.indexOf(page);
            }
          }
        }
      }
    }

    // Fallback to full search with early termination
    for (var i = 0; i < pages.length; i++) {
      final page = pages[i];
      if (page.paragraphs.isNotEmpty) {
        // Early termination: if the first paragraph index is greater than target, we've gone too far
        if (page.paragraphs.first.paragraphIndex > targetParagraphIndex) break;

        final paragraph = page.paragraphs.firstWhereOrNull(
          (p) => p.paragraphIndex == targetParagraphIndex,
        );

        if (paragraph != null) {
          final line = paragraph.lines.firstWhereOrNull(
            (l) => l.lineIndex == targetLineIndex,
          );

          if (line != null) {
            return i;
          }
        }
      }
    }

    // If nothing found, return the first page as fallback
    return 0;
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
