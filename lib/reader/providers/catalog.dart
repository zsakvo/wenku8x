import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ubuntu_logger/ubuntu_logger.dart';
import 'package:wenku8x/app/libs/request/apis.dart';
import 'package:wenku8x/app/models/catalog.dart';
import 'package:wenku8x/app/services/path.dart';

part 'catalog.g.dart';

final logger = Logger("CatalogProvider");

@riverpod
class Catalog extends _$Catalog {
  @override
  Future<CatalogModel> build(String aid) async {
    late CatalogModel _cachedCatalog = CatalogModel(aid: aid, volumes: []);
    if (await catalogFile.exists()) {
      try {
        final content = await catalogFile.readAsString();
        _cachedCatalog = CatalogModel.fromJson(jsonDecode(content));
      } catch (e) {
        logger.debug("Error reading catalog file: $e");
      }
      _fetch();
    }

    return _cachedCatalog;
  }

  _fetch() {
    Api.getNovelIndex(aid)
        .then((catalog) {
          // Save to cache
          catalogFile
              .create(recursive: true)
              .then((file) {
                state = AsyncValue.data(catalog);
                file.writeAsString(jsonEncode(catalog.toJson()));
              })
              .catchError((e) {
                logger.error("Failed to write catalog to file: $e");
              });
        })
        .catchError((e) {
          logger.error("Error fetching novel index: $e");
        });
  }

  refresh() {
    state = const AsyncValue.loading();
    _fetch();
  }

  File get catalogFile =>
      File(join(PathService().booksDirectory, aid, "catalog.json"));
}
