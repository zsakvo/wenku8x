import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wenku8x/app/libs/request/apis.dart';
import 'package:wenku8x/app/models/book.dart';

part 'books.g.dart';

@riverpod
class Books extends _$Books {
  @override
  Future<List<BookModel>> build() async {
    final books = await Api.getShelfBookList();
    return books ?? [];
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
