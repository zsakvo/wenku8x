import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wenku8x/app/libs/request/apis.dart';
import 'package:wenku8x/app/services/path.dart';
import 'package:wenku8x/app/utils/flash.dart';

part 'sign.g.dart';

@riverpod
class UserSign extends _$UserSign {
  @override
  bool build() {
    if (signedFile.existsSync()) {
      final lastSign = signedFile.readAsStringSync();
      final now = DateTime.now();
      final lastSignDate = DateTime.parse(lastSign);
      return now.year == lastSignDate.year &&
          now.month == lastSignDate.month &&
          now.day == lastSignDate.day;
    } else {
      return false;
    }
  }

  Future<void> sign() async {
    final now = DateTime.now();
    Api.doUserSign().then((res) {
      if (res.toString() == "9") {
        FlashHelper.showError("一天只能签到一次噢~");
      }
      signedFile.writeAsStringSync(now.toIso8601String());
      state = true;
    });
  }

  File get signedFile => File("${PathService().temporaryDirectory}/signed");
}
