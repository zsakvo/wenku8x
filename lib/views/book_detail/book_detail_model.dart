import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xml/xml.dart';

import '../../http/api.dart';
import '../../modals/book_meta.dart';
import '../../utils/log.dart';

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
  setTitle(title) {
    state = title;
  }
}

final bookMetaProvider1 =
    StateNotifierProvider<BookMetaNotifier, BookMeta>((ref) {
  return BookMetaNotifier();
});

class BookMetaNotifier extends StateNotifier<BookMeta> {
  BookMetaNotifier() : super(BookMeta());

  load(aid) async {
    var res = await API.getNovelFullMeta(aid);
    Log.i(res);
    List<XmlNode> elements = [];
    if (res != null) {
      for (var element in res.children[2].children) {
        if (element.toString().length > 2) elements.add(element);
      }
      state = BookMeta(
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
          latestSection: elements[10].innerText);
    }
  }
}

final bookIntroProvider =
    StateNotifierProvider<BookIntroNotifier, String>((ref) {
  return BookIntroNotifier();
});

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
