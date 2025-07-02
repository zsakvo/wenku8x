import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ubuntu_logger/ubuntu_logger.dart';
import 'package:wenku8x/app/models/book.dart';
import 'package:wenku8x/app/models/user.dart';
import 'package:wenku8x/app/services/path.dart';
import 'package:xml/xml.dart';

import 'dio.dart';

final logger = Logger("Api");

class Api {
  /// 登陆
  static login(String username, String password) async {
    final usernameEncoded = Uri.encodeComponent(username);
    final passwordEncoded = Uri.encodeComponent(password);
    return await Ajax.post(
      "action=login&username=$usernameEncoded&password=$passwordEncoded",
      isXml: false,
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
    await Ajax.post(
      "action=avatar",
      isXml: false,
      download: true,
      savePath: path,
    );
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

  static Future<List<BookModel>?> getNovelList(String sorter, int page) async {
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
    var res = await Ajax.post(
      "action=book&do=intro&aid=$aid&t=0",
      isXml: false,
    );
    return res.toString();
  }
}
