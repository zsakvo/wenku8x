import 'dart:convert';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/screen/reader/reader_provider.dart';
import 'package:wenku8x/utils/flash.dart';

part 'download_provider.freezed.dart';

enum BookDownloadStatus {
  none, // 未下载
  preparing, // 准备中
  downloading, // 下载中
  // pause,  // 暂停
  finish, // 完成
  // error,  // 错误
}

@freezed
class BookDownloader with _$BookDownloader {
  const BookDownloader._();
  const factory BookDownloader(
      {required String aid,
      @Default(BookDownloadStatus.none) BookDownloadStatus status,
      @Default(0) int cachedNum,
      @Default(false) bool canDownload
      // @Default("") String progress
      }) = _BookDownloader;

  Future<String> get progress async {
    final docDir = (await getApplicationDocumentsDirectory()).path;
    final bookDir = Directory("$docDir/books/$aid");
    final file = File("${bookDir.path}/catalog.json");
    if (!file.existsSync()) {
      if (status == BookDownloadStatus.preparing) {
        return "准备中";
      } else {
        return "缓存"; // 未下载
      }
    } else {
      if (status == BookDownloadStatus.finish) return "已下载";
      final chapters =
          (json.decode(file.readAsStringSync()) as List<dynamic>).map((e) {
        return Chapter(cid: e['cid'], name: e['name']);
      }).toList();
      final percent = cachedNum / chapters.length;
      // return "${(percent * 100).toStringAsFixed(2)}%";
      if (percent == 1) {
        return "已下载";
      } else {
        if (status == BookDownloadStatus.downloading) {
          return "正在下载\t${(percent * 100).toStringAsFixed(1)}%";
        } else {
          return "已下载\t${(percent * 100).toStringAsFixed(1)}%";
        }
      }
    }
  }
}

class BookDownloaderNotifier extends FamilyNotifier<BookDownloader, String> {
  @override
  build(arg) {
    Future(() {
      _init(arg);
    });
    return BookDownloader(aid: arg);
  }

  // 下载书籍
  download(String aid) async {
    // 获取当前书籍进度，判断是否需要下载
    if (state.status == BookDownloadStatus.finish) {
      Show.info("请不要重复下载书籍~");
      return true;
    }
    if (state.status == BookDownloadStatus.downloading ||
        state.status == BookDownloadStatus.preparing) {
      return;
    }
    // 准备下载书籍（先获取目录）
    state = state.copyWith(status: BookDownloadStatus.preparing);
    final docDir = (await getApplicationDocumentsDirectory()).path;
    final bookDir = Directory("$docDir/books/$aid");
    List<Chapter> chapters = await _getCatalog(aid);
    // 开始下载
    state = state.copyWith(status: BookDownloadStatus.downloading);
    // 下载章节
    for (var i = 0; i < chapters.length; i++) {
      final chapter = chapters[i];
      final file = File("${bookDir.path}/${chapter.cid}.txt");
      if (!file.existsSync()) {
        if (!bookDir.existsSync()) bookDir.createSync(recursive: true);
        final content = await API.getNovelContent(aid, chapter.cid);
        file.writeAsString(content);
      }
      state = state.copyWith(cachedNum: i + 1);
    }
    // 下载完成
    state = state.copyWith(status: BookDownloadStatus.finish);
  }

  // 获取目录
  Future<List<Chapter>> _getCatalog(String aid) async {
    final docDir = await getApplicationDocumentsDirectory();
    final bookDir = Directory("${docDir.path}/books/$aid");

    final file = File("${bookDir.path}/catalog.json");
    List<Chapter> chapters = [];
    if (file.existsSync()) {
      // 如果存在目录文件，直接从文件读取并更新目录
      chapters =
          (json.decode(file.readAsStringSync()) as List<dynamic>).map((e) {
        return Chapter(cid: e['cid'], name: e['name']);
      }).toList();
    } else {
      if (!bookDir.existsSync()) bookDir.createSync(recursive: true);
      chapters = await API.getNovelIndex(aid);
      file.writeAsString(jsonEncode(chapters));
    }
    return chapters;
  }

  // 获取下载状态
  Future _init(String aid) async {
    final docDir = (await getApplicationDocumentsDirectory()).path;
    final bookDir = Directory("$docDir/books/$aid");
    // 获取已缓存的文件数目（当前书籍目录下后缀为 txt 的文件数目）
    if (bookDir.existsSync()) {
      final cachedNum = bookDir
          .listSync()
          .where((e) {
            return e.path.endsWith(".txt");
          })
          .toList()
          .length;

      BookDownloadStatus status = BookDownloadStatus.none;
      if (cachedNum == (await _getCatalog(aid)).length) {
        status = BookDownloadStatus.finish;
      }
      state = BookDownloader(aid: aid, cachedNum: cachedNum, status: status);
      // return downloader;
    } else {
      state = BookDownloader(aid: aid);
    }
  }
}

final bookDownloaderProvider =
    NotifierProvider.family<BookDownloaderNotifier, BookDownloader, String>(
        BookDownloaderNotifier.new);
