// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discover.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiscoverModel {

 String get type; String get flag;
/// Create a copy of DiscoverModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoverModelCopyWith<DiscoverModel> get copyWith => _$DiscoverModelCopyWithImpl<DiscoverModel>(this as DiscoverModel, _$identity);

  /// Serializes this DiscoverModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverModel&&(identical(other.type, type) || other.type == type)&&(identical(other.flag, flag) || other.flag == flag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,flag);

@override
String toString() {
  return 'DiscoverModel(type: $type, flag: $flag)';
}


}

/// @nodoc
abstract mixin class $DiscoverModelCopyWith<$Res>  {
  factory $DiscoverModelCopyWith(DiscoverModel value, $Res Function(DiscoverModel) _then) = _$DiscoverModelCopyWithImpl;
@useResult
$Res call({
 String type, String flag
});




}
/// @nodoc
class _$DiscoverModelCopyWithImpl<$Res>
    implements $DiscoverModelCopyWith<$Res> {
  _$DiscoverModelCopyWithImpl(this._self, this._then);

  final DiscoverModel _self;
  final $Res Function(DiscoverModel) _then;

/// Create a copy of DiscoverModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? flag = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,flag: null == flag ? _self.flag : flag // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DiscoverModel extends DiscoverModel {
  const _DiscoverModel({this.type = "visit", this.flag = "allvisit"}): super._();
  factory _DiscoverModel.fromJson(Map<String, dynamic> json) => _$DiscoverModelFromJson(json);

@override@JsonKey() final  String type;
@override@JsonKey() final  String flag;

/// Create a copy of DiscoverModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiscoverModelCopyWith<_DiscoverModel> get copyWith => __$DiscoverModelCopyWithImpl<_DiscoverModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiscoverModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiscoverModel&&(identical(other.type, type) || other.type == type)&&(identical(other.flag, flag) || other.flag == flag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,flag);

@override
String toString() {
  return 'DiscoverModel(type: $type, flag: $flag)';
}


}

/// @nodoc
abstract mixin class _$DiscoverModelCopyWith<$Res> implements $DiscoverModelCopyWith<$Res> {
  factory _$DiscoverModelCopyWith(_DiscoverModel value, $Res Function(_DiscoverModel) _then) = __$DiscoverModelCopyWithImpl;
@override @useResult
$Res call({
 String type, String flag
});




}
/// @nodoc
class __$DiscoverModelCopyWithImpl<$Res>
    implements _$DiscoverModelCopyWith<$Res> {
  __$DiscoverModelCopyWithImpl(this._self, this._then);

  final _DiscoverModel _self;
  final $Res Function(_DiscoverModel) _then;

/// Create a copy of DiscoverModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? flag = null,}) {
  return _then(_DiscoverModel(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,flag: null == flag ? _self.flag : flag // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
