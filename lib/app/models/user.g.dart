// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  rank: json['rank'] as String,
  score: (json['score'] as num).toInt(),
  nickname: json['nickname'] as String,
  uname: json['uname'] as String,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'score': instance.score,
      'nickname': instance.nickname,
      'uname': instance.uname,
    };
