import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ubuntu_logger/ubuntu_logger.dart';
import 'package:wenku8x/app/libs/request/apis.dart';
import 'package:wenku8x/app/models/catalog.dart';

part 'catalog.g.dart';

final logger = Logger("CatalogProvider");

@riverpod
class Catalog extends _$Catalog {
  @override
  FutureOr<CatalogModel> build(String aid) async {
    return await delayedRequest(() => Api.getNovelIndex(aid), minDuration: 700);
  }
}
