// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PreferenceModel _$PreferenceModelFromJson(Map<String, dynamic> json) =>
    _PreferenceModel(
      brightness:
          $enumDecodeNullable(_$AppBrightnessEnumMap, json['brightness']) ??
          AppBrightness.system,
      styleMode:
          $enumDecodeNullable(_$StyleModeEnumMap, json['styleMode']) ??
          StyleMode.preset,
      language:
          $enumDecodeNullable(_$AppLanguageEnumMap, json['language']) ??
          AppLanguage.sc,
    );

Map<String, dynamic> _$PreferenceModelToJson(_PreferenceModel instance) =>
    <String, dynamic>{
      'brightness': _$AppBrightnessEnumMap[instance.brightness]!,
      'styleMode': _$StyleModeEnumMap[instance.styleMode]!,
      'language': _$AppLanguageEnumMap[instance.language]!,
    };

const _$AppBrightnessEnumMap = {
  AppBrightness.system: 'system',
  AppBrightness.light: 'light',
  AppBrightness.dark: 'dark',
};

const _$StyleModeEnumMap = {StyleMode.preset: 'preset', StyleMode.md3: 'md3'};

const _$AppLanguageEnumMap = {AppLanguage.sc: 'sc', AppLanguage.tc: 'tc'};
