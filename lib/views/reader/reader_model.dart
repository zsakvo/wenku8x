// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wenku8x/modals/chapter.dart';
import 'package:wenku8x/utils/log.dart';

import '../../http/api.dart';
import '../../modals/current.dart';

final catalogProvider = FutureProvider.autoDispose.family<List<Chapter>, dynamic>(
  (ref, aid) async {
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
    }
    return chapters;
  },
);

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
    str = """${str}document.addEventListener('DOMContentLoaded', function() {   setTimeout(() => {
          ReaderJs.setPageProperties({  topPos: 40,
          bottomPos: 24,  layoutStyle: $layoutStyle,    flowStyle: $flowStyle,    tocAnchorList: [],    paperPageToAnchorMap: {},    apiLevel: ${23}, bookName:'测试书籍名称'});
           ReaderJs.setMarginHorizontal(24);    ReaderJs.setMarginVertical(90);      /*ReaderJs.setFontSize($fontSize);*/      ReaderJs.setLineSpacing($mLineSpacing);   ReaderJs.setTextAlign($mTextAlign);
     
      ReaderThemes.set({
          backgroundColor: "f7f1e8",
          textColor: "black",
          linkColor: "black"
        });
      })});</script>""";
  }
  // str = "$str</script><style type='text/css' id='__LithiumThemeStyle'></style>";
  return pageStr.substring(0, i) + str + pageStr.substring(i);
}

getThemeCode() {
  var bgColor = ReaderThemes[currentTheme]!["backgroundColor"]!.toRadixString(16).replaceAll("ff", "");
  var textColor = ReaderThemes[currentTheme]!["textColor"]!.toRadixString(16).replaceAll("ff", "");

  return """
 ReaderThemes.set({
          backgroundColor: "$bgColor",
          textColor: "$textColor",
          linkColor: "black"
        });
""";
}

buildCurrent(String aid, List<Chapter> catalog, ref) {
  ref.read(currentStatusProvider.notifier).set(
      Current.fromMap({"aid": aid, "page": 0, "cid": catalog[0].cid, "chapter": 0, "chapterName": catalog[0].name}));
  Log.d(ref.read(currentStatusProvider));
}

final contentProvider = FutureProvider.autoDispose.family<String, dynamic>(
  (ref, aid) async {
    // final catalog = ref.watch(catalogProvider(aid)).whenData<List<Chapter>>((value) {
    //   return value;
    // });
    initBookDir(aid);
    final catalog = await ref.watch(catalogProvider(aid).future);
    buildCurrent(aid, catalog, ref);
    Log.d("message:$aid");
    catalog.take(3).forEach((element) {
      Log.d(element.json);
    });
    // await Future.delayed(Duration(seconds: 3));
    var res = await API.getNovelContent(aid, catalog[0].cid);
    List<String> arr = res.split(RegExp(r"\n\s*|\s{2,}"));
    String title = catalog[0].name;
    arr.removeRange(0, 2);
    String content = arr.map((e) => """<p style="text-align:justify;">$e</p>""").join("\n");
    String html = getPageString(title, content);
    final docDir = await getApplicationDocumentsDirectory();
    final file = File("${docDir.path}/books/$aid/${catalog[0].cid}.html");
    file.writeAsStringSync(html);
    Log.d(file.path);
    return "file://${file.path}";
  },
);

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

final loadingStatusProvider = StateNotifierProvider.autoDispose<LoadingStatus, bool>((ref) {
  return LoadingStatus();
});

class LoadingStatus extends StateNotifier<bool> {
  LoadingStatus() : super(true);
  int count = 0;
  void toggle() => state = !state;
  void increase() {
    count++;
    Log.d(count, "计数");
    if (count == 2) state = false;
  }

  void clear() {
    count = 0;
    state = true;
  }
}

final currentStatusProvider = StateNotifierProvider.autoDispose<CurrentStatusNotifier, Current>(
  (ref) {
    return CurrentStatusNotifier();
  },
);

class CurrentStatusNotifier extends StateNotifier<Current> {
  CurrentStatusNotifier() : super(const Current(page: 0));
  set(Current _current) {
    state = _current;
  }

  increasePage() {
    state.copyWith(page: state.page! + 1);
    Log.d(state, "increaase");
  }

  decreasePage() {
    state.copyWith(page: state.page! - 1);
    Log.d(state, "decreaase");
  }
}
