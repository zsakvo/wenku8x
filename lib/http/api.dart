import 'package:xml/xml.dart';

import '../modals/case_book.dart';
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
}
