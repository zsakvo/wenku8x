// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiscoverModel _$DiscoverModelFromJson(Map<String, dynamic> json) =>
    _DiscoverModel(
      type: json['type'] as String? ?? "visit",
      flag: json['flag'] as String? ?? "allvisit",
    );

Map<String, dynamic> _$DiscoverModelToJson(_DiscoverModel instance) =>
    <String, dynamic>{'type': instance.type, 'flag': instance.flag};
