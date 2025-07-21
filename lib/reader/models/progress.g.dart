// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProgressModel _$ProgressModelFromJson(Map<String, dynamic> json) =>
    _ProgressModel(
      bookId: json['bookId'] as String,
      chapterId: json['chapterId'] as String,
      paragraphIndex: (json['paragraphIndex'] as num?)?.toInt() ?? 0,
      lineIndex: (json['lineIndex'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ProgressModelToJson(_ProgressModel instance) =>
    <String, dynamic>{
      'bookId': instance.bookId,
      'chapterId': instance.chapterId,
      'paragraphIndex': instance.paragraphIndex,
      'lineIndex': instance.lineIndex,
    };
