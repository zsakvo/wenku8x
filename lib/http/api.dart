import 'package:path_provider/path_provider.dart';
import 'package:wenku8x/screen/home/home_provider.dart';
import 'package:wenku8x/screen/profile/profile_provider.dart';
import 'package:wenku8x/screen/reader/reader_provider.dart';
import 'package:wenku8x/utils/flash.dart';
import 'package:wenku8x/utils/log.dart';

import 'package:wenku8x/utils/util.dart';
import 'package:xml/xml.dart';

import 'ajax.dart';

class API {
  /// 登陆
  static login(
    String username,
    String password,
  ) async {
    final username_encoded = Uri.encodeComponent(username);
    final password_encoded = Uri.encodeComponent(password);
    return await Ajax.post(
        "action=login&username=$username_encoded&password=$password_encoded",
        isXml: false);
  }

  static Future<List<BookItem>?> getShelfBookList() async {
    XmlDocument? res = await Ajax.post("action=bookcase&t=SC");
    if (res != null) {
      List<BookItem> books = [];
      var elements = res.children[2].children
          .where((element) => element.toString().length > 4)
          .toList();
      for (var i = 0; i < elements.length; i++) {
        var element = elements[i];
        var ec = element.children;
        String aid = element.getAttribute("aid")!;
        books.add(BookItem(
            aid: aid,
            name: ec[1].innerText,
            cover: Util.getCover(aid),
            lastUpdate: element.getAttribute("date")!,
            lastChapterId: ec[3].getAttribute("cid")!,
            lastChapter: ec[3].innerText));
      }
      return books;
    }
    return null;
  }

  static Future<List<Chapter>> getNovelIndex(String aid) async {
    XmlDocument? res = await Ajax.post("action=book&do=list&aid=$aid&t=0");
    List<Chapter> chapters = [];
    if (res != null) {
      for (var element in res.children[2].children) {
        if (element.toString().length > 2) {
          int i = 0;
          for (var node in element.children) {
            if (node.toString().length > 2) {
              if (i != 0) {
                chapters.add(Chapter(
                    cid: node.getAttribute("cid").toString(),
                    name: node.innerText));
              }
            }
            i++;
          }
        }
      }
    }
    return chapters;
  }

  static getNovelContent(String aid, String cid) async {
    return await Ajax.post("action=book&do=text&aid=$aid&cid=$cid&t=0",
        isXml: false);
  }

  static Future<XmlDocument?> searchNovelByNovelName(String bookName) async {
    XmlDocument? res = await Ajax.post(
        "action=search&searchtype=articlename&searchkey=$bookName&t=0");
    return res;
  }

  static Future<XmlDocument?> searchNovelByAuthorName(String author) async {
    XmlDocument? res = await Ajax.post(
        "action=search&searchtype=author&searchkey=$author&t=0");
    return res;
  }

  static Future<XmlDocument?> getNovelFullMeta(String aid) async {
    XmlDocument? res = await Ajax.post("action=book&do=meta&aid=$aid&t=0");
    return res;
  }

  static Future<String> getNovelFullIntro(
    String aid,
  ) async {
    var res =
        await Ajax.post("action=book&do=intro&aid=$aid&t=0", isXml: false);
    return res.toString();
  }

  static Future<XmlDocument?> getNovelList(String sorter, int page) async {
    // List<ListBook> list = [];
    XmlDocument? res =
        await Ajax.post("action=novellist&sort=$sorter&page=$page&t=0");
    return res;
  }

  static Future getUserInfo(dynamic container) async {
    XmlDocument? res = await Ajax.post("action=userinfo");
    getUserAvatar().then((_) => container
        .read(avatarExistProvider.notifier)
        .state = DateTime.now().millisecondsSinceEpoch);
    if (res != null) {
      final children = res.children[2].children;
      // Log.e(res.children);
      // Log.e(children[1].innerText);
      // for (var element in res.children[2].children) {
      //   Log.e(element.innerText);
      // }
      container.read(profileProvider.notifier).state = UserInfo(
        uname: children[1].innerText,
        nickname: children[3].innerText,
        score: int.parse(children[5].innerText),
        rank: children[9].innerText,
      );
    }
  }

  static Future getUserSign(dynamic ref) async {
    var res = await Ajax.post("action=block&do=sign", isXml: false);
    if (res.toString() == "9") {
      Show.error("一天只能签到一次噢~");
    } else {
      Show.success("签到成功，积分可能需要稍等一会儿才会刷新~");
      getUserInfo(ref);
    }
  }

  static Future getUserAvatar() async {
    final docDir = await getApplicationDocumentsDirectory();
    Log.e(docDir.path);
    await Ajax.post("action=avatar",
        isXml: false, download: true, savePath: "${docDir.path}/avatar.jpg");
  }

  static Future addToBookShelf(String aid) async {
    Ajax.post("action=bookcase&do=add&aid=$aid", isXml: false);
  }

  static Future removeFromBookShelf(String aid) async {
    Ajax.post("action=bookcase&do=del&aid=$aid", isXml: false);
  }
}
