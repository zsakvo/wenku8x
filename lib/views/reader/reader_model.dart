import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:wenku8x/utils/log.dart';

import '../../http/api.dart';
import '../../modals/chapter.dart';
import 'novel_text.dart';

List<AnimationController> novelControllers = [];

final catalogProvider =
    FutureProvider.autoDispose.family<List<Chapter>, dynamic>((ref, aid) async {
  List<Chapter> chapters = [];
  var res = await API.getNovelIndex(aid);
  if (res != null) {
    for (var element in res.children[2].children) {
      if (element.toString().length > 2) {
        int i = 0;
        for (var node in element.children) {
          if (node.toString().length > 2) {
            if (i != 0) {
              chapters.add(
                  Chapter(node.getAttribute("cid").toString(), node.innerText));
            }
          }
          i++;
        }
      }
    }
  }
  if (chapters.isNotEmpty) {
    ref
        .read(currentProvider.notifier)
        .set(aid, chapters[0].cid, 0, 0, chapters[0].name);
  } else {
    Exception("目录读取失败");
  }
  return chapters;
});

final currentProvider = StateNotifierProvider<CurrentNotifier, Current?>((ref) {
  return CurrentNotifier();
});

class CurrentNotifier extends StateNotifier<Current?> {
  CurrentNotifier() : super(null);
  set(aid, cid, page, cIndex, chapterName) {
    state = Current(
        aid: aid,
        cid: cid,
        page: page,
        cIndex: cIndex,
        chapterName: chapterName);
  }

  previous() {
    novelControllers[state!.page].forward();
    state!.setPage(state!.page - 1);
  }

  next() {
    novelControllers[state!.page].reverse();
    state!.setPage(state!.page + 1);
  }
}

final config = TextConfig(
    animation: 'cover',
    showInfo: true,
    topPadding: 4,
    bottomPadding: 4,
    justifyHeight: true,
    underLine: false,
    fontSize: 17,
    paragraphPadding: 16,
    titlePaddingTop: 48,
    titlePaddingBottom: 64,
    background: "assets/bg/008.png",
    fontColor: const Color(0xff010203),
    backgroundColor: const Color(0xfff0f0f0));

final readerProvider =
    FutureProvider.family<List<Widget>, dynamic>((ref, context) async {
  final current = ref.watch(currentProvider) as Current;
  var res = await API.getNovelContent(current.aid, current.cid) as String;
  List<String> arr = res.split(RegExp(r"\n\s*|\s{2,}"));
  var novelText = NovelText(res,
      config: config,
      chapterName: current.chapterName!,
      bookName: "乐园杂音",
      tickerProvider: context, splitter: (res) {
    Log.d(arr);
    arr.removeRange(0, 2);
    return arr;
  }, getCuttentPage: () {
    return current.page;
  });
  novelControllers = novelText.controllers;
  return novelText.pages;
  // return [Text("2333")];
});

class Current {
  String aid;
  String cid;
  int page;
  int cIndex;
  String? chapterName;
  Current(
      {required this.aid,
      required this.cid,
      required this.page,
      required this.cIndex,
      this.chapterName});

  setAid(arg) {
    aid = arg;
  }

  setCid(arg) {
    cid = arg;
  }

  setPage(arg) {
    page = arg;
  }
}

onPageTap(detail, context, WidgetRef ref) {
  final size = MediaQuery.of(context).size;
  final current = ref.read(currentProvider.notifier);
  if (detail.globalPosition.dx < size.width / 2) {
    current.previous();
    // novelControllers[currentPage].forward();
    // currentPage--;
  } else {
    current.next();
    // novelControllers[currentPage].reverse();
    // currentPage++;
  }
}
