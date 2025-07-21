// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_visible.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MenuVisible _$MenuVisibleFromJson(Map<String, dynamic> json) => _MenuVisible(
  bottom: json['bottom'] as bool? ?? false,
  top: json['top'] as bool? ?? false,
  catalog: json['catalog'] as bool? ?? false,
  typography: json['typography'] as bool? ?? false,
  bookmark: json['bookmark'] as bool? ?? false,
  config: json['config'] as bool? ?? false,
);

Map<String, dynamic> _$MenuVisibleToJson(_MenuVisible instance) =>
    <String, dynamic>{
      'bottom': instance.bottom,
      'top': instance.top,
      'catalog': instance.catalog,
      'typography': instance.typography,
      'bookmark': instance.bookmark,
      'config': instance.config,
    };
