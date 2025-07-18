import 'dart:convert';
import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ubuntu_logger/ubuntu_logger.dart';
import 'package:wenku8x/app/services/path.dart';
import 'package:wenku8x/preference/models/preference.dart';

part 'preference.g.dart';

@Riverpod(keepAlive: true)
class Preference extends _$Preference {
  final logger = Logger("PreferenceProvider");
  @override
  PreferenceModel build() {
    logger.debug("加载用户偏好设置");
    listenSelf((previous, next) {
      if (previous != next) {
        logger.debug("偏好设置已更新: $next");
        configFile.writeAsStringSync(jsonEncode(next.toJson()));
      }
    });
    if (!configFile.existsSync()) {
      logger.debug("偏好设置文件不存在，使用默认设置");
      return const PreferenceModel();
    } else {
      try {
        final json = configFile.readAsStringSync();
        return PreferenceModel.fromJson(jsonDecode(json));
      } catch (e) {
        logger.error("读取偏好设置文件失败: $e");
        return const PreferenceModel();
      }
    }
  }

  setBrightness(AppBrightness brightness) {
    state = state.copyWith(brightness: brightness);
  }

  File get configFile {
    final path = "${PathService().applicationSupportDirectory}/preference.json";
    return File(path);
  }
}
