// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatalogModel _$CatalogModelFromJson(Map<String, dynamic> json) =>
    _CatalogModel(
      aid: json['aid'] as String,
      volumes: (json['volumes'] as List<dynamic>)
          .map((e) => VolumeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CatalogModelToJson(_CatalogModel instance) =>
    <String, dynamic>{'aid': instance.aid, 'volumes': instance.volumes};

_VolumeModel _$VolumeModelFromJson(Map<String, dynamic> json) => _VolumeModel(
  title: json['title'] as String,
  vid: json['vid'] as String,
  chapters: (json['chapters'] as List<dynamic>)
      .map((e) => ChapterModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$VolumeModelToJson(_VolumeModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'vid': instance.vid,
      'chapters': instance.chapters,
    };

_ChapterModel _$ChapterModelFromJson(Map<String, dynamic> json) =>
    _ChapterModel(title: json['title'] as String, cid: json['cid'] as String);

Map<String, dynamic> _$ChapterModelToJson(_ChapterModel instance) =>
    <String, dynamic>{'title': instance.title, 'cid': instance.cid};
