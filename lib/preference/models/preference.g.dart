// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PreferenceModel _$PreferenceModelFromJson(Map<String, dynamic> json) =>
    _PreferenceModel(
      brightness:
          $enumDecodeNullable(_$ThemeModeEnumMap, json['brightness']) ??
          ThemeMode.system,
      styleMode:
          $enumDecodeNullable(_$StyleModeEnumMap, json['styleMode']) ??
          StyleMode.preset,
      language:
          $enumDecodeNullable(_$AppLanguageEnumMap, json['language']) ??
          AppLanguage.sc,
      autoSignIn: json['autoSignIn'] as bool? ?? false,
    );

Map<String, dynamic> _$PreferenceModelToJson(_PreferenceModel instance) =>
    <String, dynamic>{
      'brightness': _$ThemeModeEnumMap[instance.brightness]!,
      'styleMode': _$StyleModeEnumMap[instance.styleMode]!,
      'language': _$AppLanguageEnumMap[instance.language]!,
      'autoSignIn': instance.autoSignIn,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

const _$StyleModeEnumMap = {StyleMode.preset: 'preset', StyleMode.md3: 'md3'};

const _$AppLanguageEnumMap = {AppLanguage.sc: 'sc', AppLanguage.tc: 'tc'};
