// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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


/// Adds pattern-matching-related methods to [DiscoverModel].
extension DiscoverModelPatterns on DiscoverModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiscoverModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiscoverModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiscoverModel value)  $default,){
final _that = this;
switch (_that) {
case _DiscoverModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiscoverModel value)?  $default,){
final _that = this;
switch (_that) {
case _DiscoverModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String flag)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiscoverModel() when $default != null:
return $default(_that.type,_that.flag);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String flag)  $default,) {final _that = this;
switch (_that) {
case _DiscoverModel():
return $default(_that.type,_that.flag);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String flag)?  $default,) {final _that = this;
switch (_that) {
case _DiscoverModel() when $default != null:
return $default(_that.type,_that.flag);case _:
  return null;

}
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
