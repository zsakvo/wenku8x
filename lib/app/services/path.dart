import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class PathService {
  static final PathService _instance = PathService._internal();

  factory PathService() {
    return _instance;
  }

  PathService._internal();

  late String applicationDocumentsDirectory;
  late String temporaryDirectory;
  late String applicationSupportDirectory;
  late String downloadsDirectory;
  late String cachesDirectory;
  late String logsDir;

  late String booksDirectory;
  late String imagesDirectory;
  late String cacheImageDirectory;

  Future<void> init() async {
    applicationDocumentsDirectory =
        (await getApplicationDocumentsDirectory()).path;
    temporaryDirectory = (await getTemporaryDirectory()).path;

    if (Platform.isAndroid || Platform.isIOS) {
      applicationSupportDirectory =
          (await getApplicationSupportDirectory()).path;
    } else {
      applicationSupportDirectory = applicationDocumentsDirectory;
    }

    booksDirectory = path.join(applicationDocumentsDirectory, 'books');
    imagesDirectory = path.join(applicationDocumentsDirectory, 'images');
    cacheImageDirectory = path.join(temporaryDirectory, 'cache_images');
    logsDir = path.join(applicationSupportDirectory, 'logs');

    await Directory(booksDirectory).create(recursive: true);
    await Directory(imagesDirectory).create(recursive: true);
    await Directory(cacheImageDirectory).create(recursive: true);
    await Directory(logsDir).create(recursive: true);

    try {
      downloadsDirectory =
          (await getDownloadsDirectory())?.path ??
          applicationDocumentsDirectory;
    } catch (_) {
      downloadsDirectory = applicationDocumentsDirectory;
    }

    try {
      cachesDirectory = (await getApplicationCacheDirectory()).path;
    } catch (_) {
      cachesDirectory = temporaryDirectory;
    }
  }

  String getBookPath(String bookId) {
    return path.join(booksDirectory, bookId);
  }

  String getImagePath(String imageName) {
    return path.join(imagesDirectory, imageName);
  }

  String getCachedImagePath(String imageUrl) {
    String filename = imageUrl.hashCode.toString();
    return path.join(cacheImageDirectory, filename);
  }
}
