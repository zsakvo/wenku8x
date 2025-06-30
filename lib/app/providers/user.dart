import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ubuntu_logger/ubuntu_logger.dart';
import 'package:wenku8x/app/libs/request/apis.dart';
import 'package:wenku8x/app/models/user.dart';
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
  @override
  Future<String> build() async {
    logger.debug("获取用户头像");
    final res = await Api.getUserAvatar();
    return res;
  }
}
