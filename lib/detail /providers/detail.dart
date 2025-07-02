import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wenku8x/app/libs/request/apis.dart';
import 'package:wenku8x/app/models/book.dart';

part 'detail.g.dart';

@riverpod
class Detail extends _$Detail {
  @override
  FutureOr<BookModel> build(BookModel book) async {
    return await Api.getNovelFullMeta(book.aid);
  }
}
