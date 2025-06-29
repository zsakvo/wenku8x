import 'package:cookie_jar/cookie_jar.dart';
import 'package:path/path.dart';
import 'package:wenku8x/app/services/path.dart';

PersistCookieJar prepareJar() {
  final path = join(PathService().applicationSupportDirectory, '.cookies');
  return PersistCookieJar(ignoreExpires: true, storage: FileStorage(path));
}
