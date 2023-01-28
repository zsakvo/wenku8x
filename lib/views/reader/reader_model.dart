// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wenku8x/modals/chapter.dart';
import 'package:wenku8x/utils/log.dart';

import '../../http/api.dart';
import '../../modals/current.dart';
import 'webview.dart';

final loading = useState(true);
final currentPage = useState(0);
double statusBarHeight = 0.0;
double bottomBarHeight = 0.0;

fetchCatalog(String aid) async {
  List<Chapter> chapters = [];
  var res = await API.getNovelIndex(aid);
  if (res != null) {
    for (var element in res.children[2].children) {
      if (element.toString().length > 2) {
        int i = 0;
        for (var node in element.children) {
          if (node.toString().length > 2) {
            if (i != 0) {
              chapters.add(Chapter(node.getAttribute("cid").toString(), node.innerText));
            }
          }
          i++;
        }
      }
    }
    chapters.take(3).forEach((element) {
      Log.d(element.json);
    });
    var uri = await fetchContent(aid, chapters[0].cid, chapters[0].name);
    setReader(uri);
  }
}

Future<String> fetchContent(String aid, String cid, String chapterName) async {
  var res = await API.getNovelContent(aid, cid);
  List<String> arr = res.split(RegExp(r"\n\s*|\s{2,}"));
  arr.removeRange(0, 2);
  String content = arr.map((e) => """<p>$e</p>""").join("\n");
  String html = getPageString(chapterName, content);
  final docDir = await getApplicationDocumentsDirectory();
  final file = File("${docDir.path}/books/$aid/$cid.html");
  file.writeAsStringSync(html);
  return "file://${file.path}";
}

setReader(String fileUrl) {
  wController.loadUrl(urlRequest: URLRequest(url: WebUri(fileUrl)));
}

initBookDir(String aid) async {
  final docDir = await getApplicationDocumentsDirectory();
  final bookDir = Directory("${docDir.path}/books/$aid");
  if (!bookDir.existsSync()) bookDir.createSync(recursive: true);
}

const libsPath = "../../reader.js";
const layoutStyle = 1;
const flowStyle = 1;
const currentTheme = "亚麻";
// List<double> mMargin = [30.0 + 32, 18.0];
late List<double> mMargin;
const mLineSpacing = 1.5;
const mTextAlign = 0;
const fontSize = 16.0;
const textSpace = 1.5;

String getPageString(String title, content) {
  final pageStr = """
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>$title</title>
</head>
<body>
  <h3 class="title" style="padding:28px 0 28px 0;">$title</h3>
  <div class="content">$content</div>
</body>
</html>
""";
  // StringBuffer sb = StringBuffer(pageStr);
  var i = 0;
  var indexOf = pageStr.indexOf("<head>");
  if (indexOf > -1) {
    i = indexOf + 6;
  } else {
    int indexOf2 = pageStr.indexOf("<head");
    if (indexOf2 > -1) {
      indexOf2 = pageStr.indexOf(">", indexOf2);
    }
    i = indexOf2 > -1 ? indexOf2 + 1 : 0;
  }
  String str = """
        <script type='text/javascript' src='$libsPath' defer=''></script>""";
  // if (layoutStyle == 1) {
  //   str =
  //       "$str<link href='$libsPath/css/default.css' rel='stylesheet' type='text/css' data-exclude-from-footnote='true'></link>";
  //   if (flowStyle == 2) {
  //     str = "$str<link href='$libsPath/css/scrolled.css' rel='stylesheet' type='text/css'></link>";
  //   }
  // }
  str = "$str<script type='text/javascript'>";
  if (layoutStyle == 1) {
    str = """$str
    document.addEventListener('DOMContentLoaded', function () {
      setTimeout(() => {
        ReaderJs.initConfig({
          layoutStyle: 1,
          flowStyle: 1,
          marginHorizontal: 18,
          marginVertical: 18,
          textAlign: 2,
          lineSpacing: 1.4,
          backgroundColor: 'f7f1e8',
          textColor: 'black',
          linkColor: 'black',
          font: '',
          topExtraHeight: $statusBarHeight,
          bottomExtraHeight: $bottomBarHeight,
          bookName: '狼与香辛料',
          chapterName: "第一幕"
        })
      })
    })</script>""";
  }
  // str = "$str</script><style type='text/css' id='__LithiumThemeStyle'></style>";
  return pageStr.substring(0, i) + str + pageStr.substring(i);
}

final ReaderThemes = {
  "亚麻": {
    "backgroundColor": 0xffE0CE9D,
    "pannelColor": 0xfff3e9c6,
    "textColor": 0xff262626,
    "indicatorColor": 0xffad867a
  },
  "青竹": {
    "backgroundColor": 0xffcddfcd,
    "pannelColor": 0xfff3fbf3,
    "textColor": 0xff262626,
    "indicatorColor": 0xff99998c
  },
  "蓝鼠": {
    "backgroundColor": 0xffcfdde1,
    "pannelColor": 0xffe2eff3,
    "textColor": 0xff262626,
    "indicatorColor": 0xffa0adaa
  },
  "桃花": {
    "backgroundColor": 0xffebcece,
    "pannelColor": 0xfff5e4e4,
    "textColor": 0xff262626,
    "indicatorColor": 0xffbfa8b3
  },
  "薄云": {
    "backgroundColor": 0xffd0d0d0,
    "pannelColor": 0xffdcdcdc,
    "textColor": 0xff262626,
    "indicatorColor": 0xffb0b0b0
  }
};
