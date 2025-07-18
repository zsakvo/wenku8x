// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PreferenceModel {

 ThemeMode get brightness; StyleMode get styleMode; AppLanguage get language; bool get autoSignIn;
/// Create a copy of PreferenceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreferenceModelCopyWith<PreferenceModel> get copyWith => _$PreferenceModelCopyWithImpl<PreferenceModel>(this as PreferenceModel, _$identity);

  /// Serializes this PreferenceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreferenceModel&&(identical(other.brightness, brightness) || other.brightness == brightness)&&(identical(other.styleMode, styleMode) || other.styleMode == styleMode)&&(identical(other.language, language) || other.language == language)&&(identical(other.autoSignIn, autoSignIn) || other.autoSignIn == autoSignIn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,brightness,styleMode,language,autoSignIn);

@override
String toString() {
  return 'PreferenceModel(brightness: $brightness, styleMode: $styleMode, language: $language, autoSignIn: $autoSignIn)';
}


}

/// @nodoc
abstract mixin class $PreferenceModelCopyWith<$Res>  {
  factory $PreferenceModelCopyWith(PreferenceModel value, $Res Function(PreferenceModel) _then) = _$PreferenceModelCopyWithImpl;
@useResult
$Res call({
 ThemeMode brightness, StyleMode styleMode, AppLanguage language, bool autoSignIn
});




}
/// @nodoc
class _$PreferenceModelCopyWithImpl<$Res>
    implements $PreferenceModelCopyWith<$Res> {
  _$PreferenceModelCopyWithImpl(this._self, this._then);

  final PreferenceModel _self;
  final $Res Function(PreferenceModel) _then;

/// Create a copy of PreferenceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? brightness = null,Object? styleMode = null,Object? language = null,Object? autoSignIn = null,}) {
  return _then(_self.copyWith(
brightness: null == brightness ? _self.brightness : brightness // ignore: cast_nullable_to_non_nullable
as ThemeMode,styleMode: null == styleMode ? _self.styleMode : styleMode // ignore: cast_nullable_to_non_nullable
as StyleMode,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as AppLanguage,autoSignIn: null == autoSignIn ? _self.autoSignIn : autoSignIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PreferenceModel extends PreferenceModel {
  const _PreferenceModel({this.brightness = ThemeMode.system, this.styleMode = StyleMode.preset, this.language = AppLanguage.sc, this.autoSignIn = false}): super._();
  factory _PreferenceModel.fromJson(Map<String, dynamic> json) => _$PreferenceModelFromJson(json);

@override@JsonKey() final  ThemeMode brightness;
@override@JsonKey() final  StyleMode styleMode;
@override@JsonKey() final  AppLanguage language;
@override@JsonKey() final  bool autoSignIn;

/// Create a copy of PreferenceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreferenceModelCopyWith<_PreferenceModel> get copyWith => __$PreferenceModelCopyWithImpl<_PreferenceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PreferenceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreferenceModel&&(identical(other.brightness, brightness) || other.brightness == brightness)&&(identical(other.styleMode, styleMode) || other.styleMode == styleMode)&&(identical(other.language, language) || other.language == language)&&(identical(other.autoSignIn, autoSignIn) || other.autoSignIn == autoSignIn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,brightness,styleMode,language,autoSignIn);

@override
String toString() {
  return 'PreferenceModel(brightness: $brightness, styleMode: $styleMode, language: $language, autoSignIn: $autoSignIn)';
}


}

/// @nodoc
abstract mixin class _$PreferenceModelCopyWith<$Res> implements $PreferenceModelCopyWith<$Res> {
  factory _$PreferenceModelCopyWith(_PreferenceModel value, $Res Function(_PreferenceModel) _then) = __$PreferenceModelCopyWithImpl;
@override @useResult
$Res call({
 ThemeMode brightness, StyleMode styleMode, AppLanguage language, bool autoSignIn
});




}
/// @nodoc
class __$PreferenceModelCopyWithImpl<$Res>
    implements _$PreferenceModelCopyWith<$Res> {
  __$PreferenceModelCopyWithImpl(this._self, this._then);

  final _PreferenceModel _self;
  final $Res Function(_PreferenceModel) _then;

/// Create a copy of PreferenceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? brightness = null,Object? styleMode = null,Object? language = null,Object? autoSignIn = null,}) {
  return _then(_PreferenceModel(
brightness: null == brightness ? _self.brightness : brightness // ignore: cast_nullable_to_non_nullable
as ThemeMode,styleMode: null == styleMode ? _self.styleMode : styleMode // ignore: cast_nullable_to_non_nullable
as StyleMode,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as AppLanguage,autoSignIn: null == autoSignIn ? _self.autoSignIn : autoSignIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
