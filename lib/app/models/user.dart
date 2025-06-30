import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String rank,
    required int score,
    required String nickname,
    required String uname,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
