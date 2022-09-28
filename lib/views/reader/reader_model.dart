import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/utils/log.dart';

import '../../current.dart';
import '../../http/api.dart';
import '../../modals/chapter.dart';
import 'novel_text.dart';

List<AnimationController> novelControllers = [];

int currentPage = 0;

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
        // .set(aid, chapters[0].cid, 0, 0, chapters[0].name);
        .set(Current(
            page: 0,
            pages: 0,
            cIndex: 0,
            aid: aid,
            cid: chapters[0].cid,
            nextCid: chapters[1].cid,
            chapterName: chapters[0].name));
  } else {
    throw Exception("目录读取失败");
  }
  return chapters;
});

final currentProvider = StateNotifierProvider<CurrentNotifier, Current>((ref) {
  return CurrentNotifier();
});

class CurrentNotifier extends StateNotifier<Current> {
  CurrentNotifier() : super(Current(page: 0, cIndex: 0, pages: 0));
  set(Current current) {
    state = current;
  }

  Current get value => state;

  previous() {
    // novelControllers[state.page].forward();
    state.chapter["ctrl"].forward();
    // state.page--;
    state = state.copyWith(page: state.page - 1);
  }

  next() {
    // novelControllers[state.page].reverse();
    state.chapter["ctrl"].reverse();
    // state.page++;
    state = state.copyWith(page: state.page + 1);
    Log.d(novelControllers, 'ctrls');
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

fetchChapterContent(
    {required TickerProvider tickerProvider,
    required dynamic ref,
    isNext = false}) async {
  CurrentNotifier currentNotifier = ref.read(currentProvider.notifier);
  Current current = currentNotifier.value;
  var res = await API.getNovelContent(
      current.aid!, isNext ? current.nextCid! : current.cid!) as String;
  List<String> arr = res.split(RegExp(r"\n\s*|\s{2,}"));
  var novelText = NovelText(res,
      config: config,
      chapterName: current.chapterName!,
      bookName: "乐园杂音",
      tickerProvider: tickerProvider, splitter: (res) {
    arr.removeRange(0, 2);
    return arr;
  }, getCurrentPage: () {
    return currentNotifier.value.page;
  });
  // var controllers = novelText.controllers;
  // var pages = novelText.pages;
  // novelControllers.addAll(controllers);
  current.pages += novelText.pages.length;
  ref.read(chaptersProvider.notifier).add(novelText.chapters);
}

// final readerProvider =
//     FutureProvider.family<List<Widget>, dynamic>((ref, context) async {
//   final current = ref.watch(currentProvider);
//   fetchChapterContent(current: current, tickerProvider: context, ref: ref);
//   return [];
// });

final chaptersProvider =
    StateNotifierProvider<ChaptersNotifier, List<dynamic>>((ref) {
  return ChaptersNotifier();
});

class ChaptersNotifier extends StateNotifier<List<dynamic>> {
  ChaptersNotifier() : super([]);
  add(List<dynamic> chapters, {refresh = false}) {
    state = [...chapters, ...state];
    Log.d(state.length, "state");
  }

  insert(List<dynamic> chapters) {
    state = [...chapters, ...state];
  }
}

// class Current {
//   String aid;
//   String cid;
//   int page;
//   int pages;
//   int cIndex;
//   String? chapterName;
//   bool fetch;
//   Current(
//       {required this.aid,
//       required this.cid,
//       required this.page,
//       required this.pages,
//       required this.cIndex,
//       required this.fetch,
//       this.chapterName});

//   setAid(arg) {
//     aid = arg;
//   }

//   setCid(arg) {
//     cid = arg;
//   }

//   setPage(arg) {
//     page = arg;
//   }

//   String get val {
//     return "aid:$aid\ncid:$cid\npage:$page\npages:$pages\ncIndex:$cIndex\nchapterName:${chapterName ?? ""}\n";
//   }
// }

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

onPageTapB(context, detail, AnimationController controller) {
  Log.d(detail, "detail");
  final size = MediaQuery.of(context).size;
  if (detail.globalPosition.dx < size.width / 2) {
    controller.forward();
  } else {
    controller.reverse();
  }
  Log.d(controller, "controller");
}

currentListener(
    Current? oldValue, Current newValue, TickerProvider ticker, ref) {
  Log.d(newValue.toMap(), 'message');
  if (oldValue?.cid == null) {
    fetchChapterContent(tickerProvider: ticker, ref: ref);
  } else if (newValue.page != oldValue?.page) {
    // 页码变化 触发进一步逻辑
    if (newValue.page == newValue.pages - 2) {
      fetchChapterContent(tickerProvider: ticker, ref: ref, isNext: true);
    }
  }
}
