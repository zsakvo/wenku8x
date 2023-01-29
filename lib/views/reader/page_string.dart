const libsPath = "../../reader.js";
const layoutStyle = 1;
const flowStyle = 1;
const currentTheme = "亚麻";

String getPageString(String title, content, dynamic statusBarHeight, dynamic bottomBarHeight) {
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
          marginVertical: 14,
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
