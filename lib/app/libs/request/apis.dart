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
}
