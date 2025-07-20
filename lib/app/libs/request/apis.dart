import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flash/flash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ubuntu_logger/ubuntu_logger.dart';
import 'package:wenku8x/app/models/book.dart';
import 'package:wenku8x/app/models/catalog.dart';
import 'package:wenku8x/app/models/user.dart';
import 'package:wenku8x/app/services/path.dart';
import 'package:wenku8x/app/utils/flash.dart';
import 'package:xml/xml.dart';

import 'dio.dart';

final logger = Logger("Api");

class Api {
  /// 登陆
  static login(String username, String password) async {
    final usernameEncoded = Uri.encodeComponent(username);
    final passwordEncoded = Uri.encodeComponent(password);
    return await Ajax.post(
      "action=login&username=$usernameEncoded&password=$passwordEncoded&usecookie=315360000",
    ).then((value) {
      final sp = SharedPreferencesAsync();
      if (value) {
        sp.setString("username", username);
        sp.setString("password", password);
      }
      return value;
    });
  }

  static Future getUserInfo() async {
    XmlDocument? res = await Ajax.post("action=userinfo");
    if (res != null) {
      logger.debug(res, "获取用户信息");
      final children = res.children[2].children;
      return UserModel(
        uname: children[1].innerText,
        nickname: children[3].innerText,
        score: int.parse(children[5].innerText),
        rank: children[9].innerText,
      );
    }
  }

  // static Future getUserSign(dynamic ref) async {
  //   var res = await Ajax.post("action=block&do=sign", isXml: false);
  //   if (res.toString() == "9") {
  //     // Show.error("一天只能签到一次噢~");
  //   } else {
  //     // Show.success("签到成功，积分可能需要稍等一会儿才会刷新~");
  //     getUserInfo(ref);
  //   }
  // }

  static Future<String> getUserAvatar() async {
    final path = "${PathService().applicationDocumentsDirectory}/avatar.jpg";
    if (await File(path).exists()) {
      logger.debug("头像已存在，删除旧头像");
      await File(path).delete();
    }
    await Ajax.download("action=avatar");
    return path;
  }

  static Future<List<BookModel>?> getShelfBookList() async {
    XmlDocument? res = await Ajax.post("action=bookcase&t=SC");
    if (res != null) {
      List<BookModel> books = [];
      var elements = res.children[2].children
          .where((element) => element.toString().length > 4)
          .toList();
      for (var i = 0; i < elements.length; i++) {
        var element = elements[i];
        var ec = element.children;
        String aid = element.getAttribute("aid")!;
        logger.debug("获取书籍", element);
        books.add(
          BookModel(
            aid: aid,
            name: ec[1].innerText,
            lastUpdate: element.getAttribute("date")!,
            lastChapterId: ec[3].getAttribute("cid")!,
            lastChapter: ec[3].innerText,
            // author: ec[5].innerText,
          ),
        );
      }
      return books;
    }
    return null;
  }

  static Future<List<BookModel>> getNovelList(String sorter, int page) async {
    XmlDocument? res = await Ajax.post(
      "action=novellist&sort=$sorter&page=$page&t=0",
    );
    logger.debug("获取小说列表", res);
    if (res != null) {
      return res.findAllElements("item").map((element) {
        var elements = element.children
            .where((p0) => p0.toString().length > 2)
            .toList();
        final aid = element.getAttribute("aid")!;
        return BookModel(
          aid: aid,
          name: elements[0].innerText,
          author: elements[4].getAttribute("value").toString(),
          status: elements[5].getAttribute("value").toString(),
          lastUpdate: elements[6].getAttribute("value").toString(),
        );
      }).toList();
    }
    return [];
  }

  static Future<BookModel> getNovelFullMeta(String aid) async {
    XmlDocument res = await Ajax.post("action=book&do=meta&aid=$aid&t=0");
    String intro = await getNovelFullIntro(aid);
    logger.debug("获取小说完整信息", res);
    var eles = res.findAllElements("data").toList();
    return BookModel(
      aid: aid,
      name: eles[0].innerText,
      author: eles[1].getAttribute("value"),
      status: eles[7].getAttribute("value"),
      lastUpdate: eles[9].getAttribute("value"),
      lastChapterId: eles[11].getAttribute("cid"),
      lastChapter: eles[11].innerText,
      dayHitsCount: int.tryParse(eles[2].getAttribute("value") ?? "0"),
      totalHitsCount: int.tryParse(eles[3].getAttribute("value") ?? "0"),
      pushCount: int.tryParse(eles[4].getAttribute("value") ?? "0"),
      favCount: int.tryParse(eles[5].getAttribute("value") ?? "0"),
      pressId: eles[6].getAttribute("sid"),
      pressName: eles[6].getAttribute("value"),
      length: int.tryParse(eles[8].getAttribute("value") ?? "0"),
      tags: eles[10].getAttribute("value")?.split(" ") ?? [],
      intro: intro,
    );
  }

  static Future<String> getNovelFullIntro(String aid) async {
    var res = await Ajax.post("action=book&do=intro&aid=$aid&t=0");
    return res.toString();
  }

  static Future<List<BookModel>> searchNovelByNovelName(String bookName) async {
    XmlDocument res = await Ajax.post(
      "action=search&searchtype=articlename&searchkey=$bookName&t=0",
    );
    return res.findAllElements("item").map((element) {
      return _parseBookFromXml(element);
    }).toList();
  }

  static Future<List<BookModel>> searchNovelByAuthorName(String author) async {
    XmlDocument res = await Ajax.post(
      "action=search&searchtype=author&searchkey=$author&t=0",
    );
    return res.findAllElements("item").map((element) {
      return _parseBookFromXml(element);
    }).toList();
  }

  /// 获取小说目录
  /// @param aid 小说的aid
  /// @return [CatalogModel] 包含小说的目录信息
  static Future<CatalogModel> getNovelIndex(String aid) async {
    XmlDocument res = await Ajax.post("action=book&do=list&aid=$aid&t=0");
    logger.debug("获取小说目录", res);
    List<VolumeModel> volumes = [];
    for (var element in res.children[2].children) {
      if (element.toString().length > 2) {
        List<ChapterModel> chapters = [];
        int i = 0;
        for (var node in element.children) {
          if (node.toString().length > 2) {
            if (i != 0) {
              chapters.add(
                ChapterModel(
                  cid: node.getAttribute("cid").toString(),
                  title: node.innerText,
                ),
              );
            }
          }
          i++;
        }
        volumes.add(
          VolumeModel(
            title: element.firstChild?.value ?? "未知卷",
            vid: element.getAttribute("vid").toString(),
            chapters: chapters,
          ),
        );
      }
    }
    return CatalogModel(aid: aid, volumes: volumes);
  }

  static getNovelContent(String aid, String cid) async {
    return await Ajax.post("action=book&do=text&aid=$aid&cid=$cid&t=0");
  }

  static Future<String> doUserSign() async {
    var res = await Ajax.post("action=block&do=sign");
    return res.toString();
  }

  static BookModel _parseBookFromXml(XmlElement element, {String? aid}) {
    var eles = element.children
        .where((p0) => p0.toString().length > 2)
        .toList();
    return BookModel(
      aid: aid ?? element.getAttribute("aid")!,
      name: eles
          .firstWhereOrNull((p0) => p0.getAttribute("name") == "Title")!
          .innerText,
      author: eles
          .firstWhereOrNull((p0) => p0.getAttribute("name") == "Author")
          ?.getAttribute("value"),
      lastChapter: eles
          .firstWhereOrNull((p0) => p0.getAttribute("name") == "LastChapter")
          ?.innerText,
      lastChapterId: eles
          .firstWhereOrNull((p0) => p0.getAttribute("name") == "LastChapter")
          ?.getAttribute("cid"),
      lastUpdate: eles
          .firstWhereOrNull((p0) => p0.getAttribute("name") == "LastUpdate")
          ?.getAttribute("value"),
      status: eles
          .firstWhereOrNull((p0) => p0.getAttribute("name") == "BookStatus")
          ?.getAttribute("value"),
      dayHitsCount: int.tryParse(
        eles
                .firstWhereOrNull(
                  (p0) => p0.getAttribute("name") == "DayHitsCount",
                )
                ?.getAttribute("value") ??
            "0",
      ),
      totalHitsCount: int.tryParse(
        eles
                .firstWhereOrNull(
                  (p0) => p0.getAttribute("name") == "TotalHitsCount",
                )
                ?.getAttribute("value") ??
            "0",
      ),
      pushCount: int.tryParse(
        eles
                .firstWhereOrNull(
                  (p0) => p0.getAttribute("name") == "PushCount",
                )
                ?.getAttribute("value") ??
            "0",
      ),
      favCount: int.tryParse(
        eles
                .firstWhereOrNull((p0) => p0.getAttribute("name") == "FavCount")
                ?.getAttribute("value") ??
            "0",
      ),
      pressId: eles
          .firstWhereOrNull((p0) => p0.getAttribute("name") == "Press")
          ?.getAttribute("sid"),
      pressName: eles
          .firstWhereOrNull((p0) => p0.getAttribute("name") == "Press")
          ?.getAttribute("value"),
      length: int.tryParse(
        eles
                .firstWhereOrNull((p0) => p0.getAttribute("name") == "Length")
                ?.getAttribute("value") ??
            "0",
      ),
      tags:
          eles
              .firstWhereOrNull((p0) => p0.getAttribute("name") == "Tags")
              ?.getAttribute("value")
              ?.split(" ") ??
          [],
    );
  }
}

/// 延时请求，确保请求至少执行指定的时长
/// @param requestFunction 要执行的请求函数
/// @param minDuration 最小执行时长（毫秒）
/// @return 返回请求函数的结果
Future<T> delayedRequest<T>(
  Future<T> Function() requestFunction, {
  int minDuration = 500,
}) async {
  final stopwatch = Stopwatch()..start();

  try {
    final result = await requestFunction();
    final elapsed = stopwatch.elapsedMilliseconds;

    if (elapsed < minDuration) {
      await Future.delayed(Duration(milliseconds: minDuration - elapsed));
    }
    return result;
  } finally {
    stopwatch.stop();
  }
}
