import 'dart:convert';

class Chapter {
  final String cid;
  final String name;

  Chapter(this.cid, this.name);

  String get json {
    return jsonEncode({"cid": cid, "name": name});
  }

  Map get map {
    return {"cid": cid, "name": name};
  }
}
