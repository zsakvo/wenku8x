import 'dart:convert';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wenku8x/main.dart';
import 'package:wenku8x/utils/flash.dart';

part 'profile_provider.freezed.dart';

@freezed
class Config with _$Config {
  const factory Config({
    @Default(true) bool autoDarkMode,
    @Default(false) bool isDarkMode,
    @Default(true) bool dynamicColor,
    @Default(0xFFF44336) int colorSeed,
    @Default(false) bool fixedSequence,
    @Default(false) bool showImage,
    @Default(false) bool zhHant,
    @Default("") String customAvataar,
  }) = _Config;

  const Config._();

  static Config fromJson(Map<String, dynamic> json) {
    return Config(
      autoDarkMode: json["autoDarkMode"] ?? true,
      isDarkMode: json["isDarkMode"] ?? false,
      dynamicColor: json["dynamicColor"] ?? true,
      colorSeed: json["colorSeed"] ?? 0xFFF44336,
      fixedSequence: json["fixedSequence"] ?? false,
      showImage: json["showImage"] ?? false,
      zhHant: json["zhHant"] ?? false,
      customAvataar: json["customAvataar"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "autoDarkMode": autoDarkMode,
      "isDarkMode": isDarkMode,
      "dynamicColor": dynamicColor,
      "colorSeed": colorSeed,
      "fixedSequence": fixedSequence,
      "showImage": showImage,
      "zhHant": zhHant,
      "customAvataar": customAvataar,
    };
  }
}

@freezed
class UserInfo with _$UserInfo {
  const UserInfo._();
  const factory UserInfo(
      {String? uname, String? nickname, int? score, String? rank}) = _UserInfo;

  static UserInfo fromJson(Map<String, dynamic> json) {
    return UserInfo(
      uname: json["uname"] ?? "",
      nickname: json["nickname"] ?? "",
      score: json["score"] ?? 0,
      rank: json["rank"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uname": uname,
      "nickname": nickname,
      "score": score,
      "rank": rank,
    };
  }
}

class ConfigNotifier extends Notifier<Config> {
  @override
  build() {
    _getAccentColor();
    return Config.fromJson(jsonDecode(sp.getString("config") ?? "{}"));
  }

  void update(Config config) {
    state = config;
    sp.setString("config", json.encode(config.toJson()));
  }

  void updateColorSeed(int colorSeed) {
    state = state.copyWith(colorSeed: colorSeed);
    sp.setString("config", json.encode(state.toJson()));
  }

  _getAccentColor() {}
}

final configProvider =
    NotifierProvider<ConfigNotifier, Config>(ConfigNotifier.new);

final profileProvider = StateProvider<UserInfo>((ref) {
  return const UserInfo(nickname: "-", rank: "-", score: 0);
});

clearCache() async {
  final dir = await getApplicationDocumentsDirectory();
  final booksDir = Directory("${dir.path}/books");
  booksDir.listSync().forEach((element) {
    if (element.statSync().type == FileSystemEntityType.directory) {
      (Directory(element.path))
          .listSync()
          .toList()
          .where((element) => !element.path.contains("meta.json"))
          .forEach((element) {
        element.deleteSync();
      });
    }
  });
  Show.success("缓存清除成功");
}

final avatarExistProvider = StateProvider<int>((ref) {
  return DateTime.now().millisecondsSinceEpoch;
});
