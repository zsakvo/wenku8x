// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Chapter _$$_ChapterFromJson(Map<String, dynamic> json) => _$_Chapter(
      cid: json['cid'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_ChapterToJson(_$_Chapter instance) =>
    <String, dynamic>{
      'cid': instance.cid,
      'name': instance.name,
    };

_$_RecordMeta _$$_RecordMetaFromJson(Map<String, dynamic> json) =>
    _$_RecordMeta(
      cIndex: json['cIndex'] as int? ?? 0,
      pIndex: json['pIndex'] as int? ?? 0,
    );

Map<String, dynamic> _$$_RecordMetaToJson(_$_RecordMeta instance) =>
    <String, dynamic>{
      'cIndex': instance.cIndex,
      'pIndex': instance.pIndex,
    };
