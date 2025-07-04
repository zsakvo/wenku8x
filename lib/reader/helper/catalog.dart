import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:path/path.dart';
import 'package:ubuntu_logger/ubuntu_logger.dart';
import 'package:wenku8x/app/libs/request/apis.dart';
import 'package:wenku8x/app/models/catalog.dart';
import 'package:wenku8x/app/services/path.dart';

final logger = Logger("CatalogHelper");

useCatalog({required String aid}) {
  final catalog = useState<CatalogModel?>(null);
  final isLoading = useState<bool>(true);
  final error = useState<String?>(null);

  final catalogFile = File(
    join(PathService().booksDirectory, aid, "catalog.json"),
  );

  Future<void> loadCatalog({bool forceRefresh = false}) async {
    try {
      isLoading.value = true;
      error.value = null;

      // Try to load from cache first (only if not forcing refresh)
      if (!forceRefresh && await catalogFile.exists()) {
        try {
          final content = await catalogFile.readAsString();
          final cachedCatalog = CatalogModel.fromJson(jsonDecode(content));
          catalog.value = cachedCatalog;
        } catch (e) {
          logger.debug("Error reading catalog file: $e");
        }
      }

      // Fetch fresh data from API
      final freshCatalog = await Api.getNovelIndex(aid);
      catalog.value = freshCatalog;

      // Save to cache
      await catalogFile.create(recursive: true);
      await catalogFile.writeAsString(jsonEncode(freshCatalog.toJson()));
    } catch (e) {
      error.value = "Failed to load catalog: $e";
      logger.error("Error fetching novel index: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refresh() async {
    await loadCatalog(forceRefresh: true);
  }

  useEffect(() {
    loadCatalog();
    return null;
  }, [aid]);

  return (
    catalog: catalog.value,
    isLoading: isLoading.value,
    error: error.value,
    refresh: refresh,
  );
}
