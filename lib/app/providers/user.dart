import 'dart:io';
import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ubuntu_logger/ubuntu_logger.dart';
import 'package:wenku8x/app/libs/request/apis.dart';
import 'package:wenku8x/app/models/user.dart';
import 'package:wenku8x/app/services/path.dart';
part 'user.g.dart';

final logger = Logger("UserProvider");

@Riverpod(keepAlive: true)
class User extends _$User {
  @override
  Future<UserModel> build() async {
    logger.debug("获取用户信息");
    final res = await Api.getUserInfo();
    if (res != null) {
      return res;
    } else {
      throw Exception("获取用户信息失败");
    }
  }

  void refresh() {
    ref.invalidateSelf();
  }
}

@riverpod
class UserAvatar extends _$UserAvatar {
  final path = "${PathService().applicationDocumentsDirectory}/avatar.jpg";
  @override
  FutureOr<Uint8List> build() async {
    logger.debug("初始化用户头像");
    if (!(await _file.exists())) {
      await Api.getUserAvatar();
    } else {
      Future(refresh);
    }
    return await _file.readAsBytes();
  }

  void refresh() async {
    await Api.getUserAvatar();
    state = AsyncValue.data((await _file.readAsBytes()));
  }

  File get _file => File(path);
}
