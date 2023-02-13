import 'package:xml/xml.dart';

import '../data/scheme/case_book.dart';
import '../modals/list_book.dart';
import '../utils/util.dart';
import 'ajax.dart';

class API {
  /// 登陆
  static login(
    String username,
    String password,
  ) async {
    return await Ajax.post("action=login&username=$username&password=$password",
        isXml: false);
  }

  static Future<List<CaseBook>> getShelfBookList() async {
    XmlDocument? res = await Ajax.post("action=bookcase&t=SC");
    List<CaseBook> books = [];
    if (res != null) {
      var elements = res.children[2].children
          .where((element) => element.toString().length > 4)
          .toList();
      for (var i = 0; i < elements.length; i++) {
        var element = elements[i];
        var ec = element.children;
        String aid = element.getAttribute("aid")!;
        var cb = CaseBook(
          ec[1].innerText,
          element.getAttribute("aid")!,
          ec[3].getAttribute("cid")!,
          0,
          0,
          Util.getCover(aid),
          element.getAttribute("date")!,
          ec[3].innerText,
        );
        books.add(cb);
      }
    }
    return books;
  }

  static Future<List<ListBook>> getNovelList(String sorter, int page) async {
    List<ListBook> list = [];
    XmlDocument? res =
        await Ajax.post("action=novellist&sort=$sorter&page=$page&t=0");
    if (res != null) {
      //  当最后一页的时候取出的节点数目为零……
      //  此时直接获取 RanksController 实例设置末页即可
      res.findAllElements("item").forEach((element) {
        var elements =
            element.children.where((p0) => p0.toString().length > 2).toList();
        list.add(ListBook(
            aid: element.getAttribute("aid")!,
            title: elements[0].innerText,
            hits: elements[1].getAttribute("value").toString(),
            push: elements[2].getAttribute("value").toString(),
            fav: elements[3].getAttribute("value").toString(),
            author: elements[4].getAttribute("value").toString(),
            status: elements[5].getAttribute("value").toString(),
            lastUpdate: elements[6].getAttribute("value").toString(),
            intro: elements[7].innerText.replaceAll("\n", "")));
      });
    }
    return list;
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

  static Future<XmlDocument?> getNovelIndex(String aid) async {
    XmlDocument? res = await Ajax.post("action=book&do=list&aid=$aid&t=0");
    return res;
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

  static getNovelContent(String aid, String cid) async {
    return await Ajax.post("action=book&do=text&aid=$aid&cid=$cid&t=0",
        isXml: false);
  }

  static getUserAvatar() async {
    return await Ajax.post("action=avatar", isXml: false);
  }

  static getUserInfoParams() async {
    return await Ajax.post("action=userinfo");
  }
}
