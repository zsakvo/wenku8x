import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/modals/chapter.dart';

import '../../http/api.dart';

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
