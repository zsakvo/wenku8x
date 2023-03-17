String cfiEscape(String str) {
  return str.replaceAll(RegExp(r'[\[\]\^,();]'), r'^$&');
}

/// 获取正则表达式在字符串中所有匹配项的索引
/// 如果 `add` 不为空，则将其添加到匹配的索引中
List<int> matchAll(String str, RegExp regExp, [int add = 0]) {
  final matches = <int>[];
  var offset = 0;
  Match? m;
  do {
    m = regExp.firstMatch(str);
    if (m == null) break;
    matches.add(m.start + add);
    offset += m.start + m.group(0)!.length;
    str = str.substring(m.start + m.group(0)!.length);
  } while (offset < str.length);

  return matches;
}

int closest(List<int> a, int n) {
  int? minDiff;
  int? closest;
  for (var i = 0; i < a.length; i++) {
    int diff = (a[i] - n).abs();
    if (minDiff == null || diff < minDiff) {
      minDiff = diff;
      closest = a[i];
    }
  }
  return closest!;
}
