import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xml/xml.dart';

import '../../http/api.dart';
import '../../modals/book_meta.dart';
import '../../modals/chapter.dart';

final drawerToggleProvider = StateNotifierProvider((ref) {
  return DrawerToggle();
});

class DrawerToggle extends StateNotifier<bool> {
  DrawerToggle() : super(false);

  void toogle() => !state;
}

final appBarTitleProvider =
    StateNotifierProvider<AppBarTitleNotifier, String>((ref) {
  return AppBarTitleNotifier();
});

class AppBarTitleNotifier extends StateNotifier<String> {
  AppBarTitleNotifier() : super("");
  String bookName = "";
  setTitle(bool hide) {
    state = hide ? "" : bookName;
  }

  setBookName(name) {
    bookName = name;
  }
}

class BookIntroNotifier extends StateNotifier<String> {
  BookIntroNotifier() : super("");

  load(aid) async {
    var res = await API.getNovelFullIntro(aid);
    state = res;
  }
}

final bookMetaProvider =
    FutureProvider.family<BookMeta, dynamic>((ref, aid) async {
  var meta = await API.getNovelFullMeta(aid);
  var intro = await API.getNovelFullIntro(aid);
  List<XmlNode> elements = [];
  if (meta != null) {
    for (var element in meta.children[2].children) {
      if (element.toString().length > 2) elements.add(element);
    }
    ref.read(appBarTitleProvider.notifier).setBookName(elements[0].innerText);
    return BookMeta(
        aid: aid,
        title: elements[0].innerText,
        author: elements[1].getAttribute("value").toString(),
        dayHits: elements[2].getAttribute("value").toString(),
        totalHits: elements[3].getAttribute("value").toString(),
        push: elements[4].getAttribute("value").toString(),
        fav: elements[5].getAttribute("value").toString(),
        pressId: elements[6].getAttribute("sid").toString(),
        pressValue: elements[6].getAttribute("value").toString(),
        status: elements[7].getAttribute("value").toString(),
        lastUpdate: elements[9].getAttribute("value").toString(),
        bookLength: elements[8].getAttribute("value").toString(),
        latestSection: elements[10].innerText,
        intro: intro);
  } else {
    throw Exception("资源请求失败");
  }
});

final catalogProvider =
    FutureProvider.family<List<Chapter>, dynamic>((ref, aid) async {
  var res = await API.getNovelIndex(aid);
  if (res != null) {
    List<Chapter> chapters = [];
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
    return chapters;
  } else {
    throw Exception("资源获取失败");
  }
});
