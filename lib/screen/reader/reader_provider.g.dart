// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChapterImpl _$$ChapterImplFromJson(Map<String, dynamic> json) =>
    _$ChapterImpl(
      cid: json['cid'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$ChapterImplToJson(_$ChapterImpl instance) =>
    <String, dynamic>{
      'cid': instance.cid,
      'name': instance.name,
    };

_$RecordMetaImpl _$$RecordMetaImplFromJson(Map<String, dynamic> json) =>
    _$RecordMetaImpl(
      cIndex: json['cIndex'] as int? ?? 0,
      pIndex: json['pIndex'] as int? ?? 0,
    );

Map<String, dynamic> _$$RecordMetaImplToJson(_$RecordMetaImpl instance) =>
    <String, dynamic>{
      'cIndex': instance.cIndex,
      'pIndex': instance.pIndex,
    };
