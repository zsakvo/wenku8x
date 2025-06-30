// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookModel _$BookModelFromJson(Map<String, dynamic> json) => _BookModel(
  aid: json['aid'] as String,
  name: json['name'] as String,
  author: json['author'] as String?,
  lastChapter: json['lastChapter'] as String?,
  lastChapterId: json['lastChapterId'] as String?,
  lastUpdate: json['lastUpdate'] as String?,
  status: json['status'] as String?,
  intro: json['intro'] as String?,
);

Map<String, dynamic> _$BookModelToJson(_BookModel instance) =>
    <String, dynamic>{
      'aid': instance.aid,
      'name': instance.name,
      'author': instance.author,
      'lastChapter': instance.lastChapter,
      'lastChapterId': instance.lastChapterId,
      'lastUpdate': instance.lastUpdate,
      'status': instance.status,
      'intro': instance.intro,
    };
