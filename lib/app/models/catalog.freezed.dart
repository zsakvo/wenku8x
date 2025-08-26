// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogModel {

 String get aid; List<VolumeModel> get volumes;
/// Create a copy of CatalogModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogModelCopyWith<CatalogModel> get copyWith => _$CatalogModelCopyWithImpl<CatalogModel>(this as CatalogModel, _$identity);

  /// Serializes this CatalogModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogModel&&(identical(other.aid, aid) || other.aid == aid)&&const DeepCollectionEquality().equals(other.volumes, volumes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,aid,const DeepCollectionEquality().hash(volumes));

@override
String toString() {
  return 'CatalogModel(aid: $aid, volumes: $volumes)';
}


}

/// @nodoc
abstract mixin class $CatalogModelCopyWith<$Res>  {
  factory $CatalogModelCopyWith(CatalogModel value, $Res Function(CatalogModel) _then) = _$CatalogModelCopyWithImpl;
@useResult
$Res call({
 String aid, List<VolumeModel> volumes
});




}
/// @nodoc
class _$CatalogModelCopyWithImpl<$Res>
    implements $CatalogModelCopyWith<$Res> {
  _$CatalogModelCopyWithImpl(this._self, this._then);

  final CatalogModel _self;
  final $Res Function(CatalogModel) _then;

/// Create a copy of CatalogModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? aid = null,Object? volumes = null,}) {
  return _then(_self.copyWith(
aid: null == aid ? _self.aid : aid // ignore: cast_nullable_to_non_nullable
as String,volumes: null == volumes ? _self.volumes : volumes // ignore: cast_nullable_to_non_nullable
as List<VolumeModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogModel].
extension CatalogModelPatterns on CatalogModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogModel value)  $default,){
final _that = this;
switch (_that) {
case _CatalogModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogModel value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String aid,  List<VolumeModel> volumes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogModel() when $default != null:
return $default(_that.aid,_that.volumes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String aid,  List<VolumeModel> volumes)  $default,) {final _that = this;
switch (_that) {
case _CatalogModel():
return $default(_that.aid,_that.volumes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String aid,  List<VolumeModel> volumes)?  $default,) {final _that = this;
switch (_that) {
case _CatalogModel() when $default != null:
return $default(_that.aid,_that.volumes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogModel extends CatalogModel {
  const _CatalogModel({required this.aid, required final  List<VolumeModel> volumes}): _volumes = volumes,super._();
  factory _CatalogModel.fromJson(Map<String, dynamic> json) => _$CatalogModelFromJson(json);

@override final  String aid;
 final  List<VolumeModel> _volumes;
@override List<VolumeModel> get volumes {
  if (_volumes is EqualUnmodifiableListView) return _volumes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_volumes);
}


/// Create a copy of CatalogModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogModelCopyWith<_CatalogModel> get copyWith => __$CatalogModelCopyWithImpl<_CatalogModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogModel&&(identical(other.aid, aid) || other.aid == aid)&&const DeepCollectionEquality().equals(other._volumes, _volumes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,aid,const DeepCollectionEquality().hash(_volumes));

@override
String toString() {
  return 'CatalogModel(aid: $aid, volumes: $volumes)';
}


}

/// @nodoc
abstract mixin class _$CatalogModelCopyWith<$Res> implements $CatalogModelCopyWith<$Res> {
  factory _$CatalogModelCopyWith(_CatalogModel value, $Res Function(_CatalogModel) _then) = __$CatalogModelCopyWithImpl;
@override @useResult
$Res call({
 String aid, List<VolumeModel> volumes
});




}
/// @nodoc
class __$CatalogModelCopyWithImpl<$Res>
    implements _$CatalogModelCopyWith<$Res> {
  __$CatalogModelCopyWithImpl(this._self, this._then);

  final _CatalogModel _self;
  final $Res Function(_CatalogModel) _then;

/// Create a copy of CatalogModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? aid = null,Object? volumes = null,}) {
  return _then(_CatalogModel(
aid: null == aid ? _self.aid : aid // ignore: cast_nullable_to_non_nullable
as String,volumes: null == volumes ? _self._volumes : volumes // ignore: cast_nullable_to_non_nullable
as List<VolumeModel>,
  ));
}


}


/// @nodoc
mixin _$VolumeModel {

 String get title; String get vid; List<ChapterModel> get chapters;
/// Create a copy of VolumeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VolumeModelCopyWith<VolumeModel> get copyWith => _$VolumeModelCopyWithImpl<VolumeModel>(this as VolumeModel, _$identity);

  /// Serializes this VolumeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VolumeModel&&(identical(other.title, title) || other.title == title)&&(identical(other.vid, vid) || other.vid == vid)&&const DeepCollectionEquality().equals(other.chapters, chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,vid,const DeepCollectionEquality().hash(chapters));

@override
String toString() {
  return 'VolumeModel(title: $title, vid: $vid, chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class $VolumeModelCopyWith<$Res>  {
  factory $VolumeModelCopyWith(VolumeModel value, $Res Function(VolumeModel) _then) = _$VolumeModelCopyWithImpl;
@useResult
$Res call({
 String title, String vid, List<ChapterModel> chapters
});




}
/// @nodoc
class _$VolumeModelCopyWithImpl<$Res>
    implements $VolumeModelCopyWith<$Res> {
  _$VolumeModelCopyWithImpl(this._self, this._then);

  final VolumeModel _self;
  final $Res Function(VolumeModel) _then;

/// Create a copy of VolumeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? vid = null,Object? chapters = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,vid: null == vid ? _self.vid : vid // ignore: cast_nullable_to_non_nullable
as String,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ChapterModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [VolumeModel].
extension VolumeModelPatterns on VolumeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VolumeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VolumeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VolumeModel value)  $default,){
final _that = this;
switch (_that) {
case _VolumeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VolumeModel value)?  $default,){
final _that = this;
switch (_that) {
case _VolumeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String vid,  List<ChapterModel> chapters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VolumeModel() when $default != null:
return $default(_that.title,_that.vid,_that.chapters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String vid,  List<ChapterModel> chapters)  $default,) {final _that = this;
switch (_that) {
case _VolumeModel():
return $default(_that.title,_that.vid,_that.chapters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String vid,  List<ChapterModel> chapters)?  $default,) {final _that = this;
switch (_that) {
case _VolumeModel() when $default != null:
return $default(_that.title,_that.vid,_that.chapters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VolumeModel extends VolumeModel {
  const _VolumeModel({required this.title, required this.vid, required final  List<ChapterModel> chapters}): _chapters = chapters,super._();
  factory _VolumeModel.fromJson(Map<String, dynamic> json) => _$VolumeModelFromJson(json);

@override final  String title;
@override final  String vid;
 final  List<ChapterModel> _chapters;
@override List<ChapterModel> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}


/// Create a copy of VolumeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VolumeModelCopyWith<_VolumeModel> get copyWith => __$VolumeModelCopyWithImpl<_VolumeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VolumeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VolumeModel&&(identical(other.title, title) || other.title == title)&&(identical(other.vid, vid) || other.vid == vid)&&const DeepCollectionEquality().equals(other._chapters, _chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,vid,const DeepCollectionEquality().hash(_chapters));

@override
String toString() {
  return 'VolumeModel(title: $title, vid: $vid, chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class _$VolumeModelCopyWith<$Res> implements $VolumeModelCopyWith<$Res> {
  factory _$VolumeModelCopyWith(_VolumeModel value, $Res Function(_VolumeModel) _then) = __$VolumeModelCopyWithImpl;
@override @useResult
$Res call({
 String title, String vid, List<ChapterModel> chapters
});




}
/// @nodoc
class __$VolumeModelCopyWithImpl<$Res>
    implements _$VolumeModelCopyWith<$Res> {
  __$VolumeModelCopyWithImpl(this._self, this._then);

  final _VolumeModel _self;
  final $Res Function(_VolumeModel) _then;

/// Create a copy of VolumeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? vid = null,Object? chapters = null,}) {
  return _then(_VolumeModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,vid: null == vid ? _self.vid : vid // ignore: cast_nullable_to_non_nullable
as String,chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ChapterModel>,
  ));
}


}


/// @nodoc
mixin _$ChapterModel {

 String get title; String get cid;
/// Create a copy of ChapterModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterModelCopyWith<ChapterModel> get copyWith => _$ChapterModelCopyWithImpl<ChapterModel>(this as ChapterModel, _$identity);

  /// Serializes this ChapterModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterModel&&(identical(other.title, title) || other.title == title)&&(identical(other.cid, cid) || other.cid == cid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,cid);

@override
String toString() {
  return 'ChapterModel(title: $title, cid: $cid)';
}


}

/// @nodoc
abstract mixin class $ChapterModelCopyWith<$Res>  {
  factory $ChapterModelCopyWith(ChapterModel value, $Res Function(ChapterModel) _then) = _$ChapterModelCopyWithImpl;
@useResult
$Res call({
 String title, String cid
});




}
/// @nodoc
class _$ChapterModelCopyWithImpl<$Res>
    implements $ChapterModelCopyWith<$Res> {
  _$ChapterModelCopyWithImpl(this._self, this._then);

  final ChapterModel _self;
  final $Res Function(ChapterModel) _then;

/// Create a copy of ChapterModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? cid = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,cid: null == cid ? _self.cid : cid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChapterModel].
extension ChapterModelPatterns on ChapterModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChapterModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChapterModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChapterModel value)  $default,){
final _that = this;
switch (_that) {
case _ChapterModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChapterModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChapterModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String cid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChapterModel() when $default != null:
return $default(_that.title,_that.cid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String cid)  $default,) {final _that = this;
switch (_that) {
case _ChapterModel():
return $default(_that.title,_that.cid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String cid)?  $default,) {final _that = this;
switch (_that) {
case _ChapterModel() when $default != null:
return $default(_that.title,_that.cid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChapterModel extends ChapterModel {
  const _ChapterModel({required this.title, required this.cid}): super._();
  factory _ChapterModel.fromJson(Map<String, dynamic> json) => _$ChapterModelFromJson(json);

@override final  String title;
@override final  String cid;

/// Create a copy of ChapterModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterModelCopyWith<_ChapterModel> get copyWith => __$ChapterModelCopyWithImpl<_ChapterModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChapterModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterModel&&(identical(other.title, title) || other.title == title)&&(identical(other.cid, cid) || other.cid == cid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,cid);

@override
String toString() {
  return 'ChapterModel(title: $title, cid: $cid)';
}


}

/// @nodoc
abstract mixin class _$ChapterModelCopyWith<$Res> implements $ChapterModelCopyWith<$Res> {
  factory _$ChapterModelCopyWith(_ChapterModel value, $Res Function(_ChapterModel) _then) = __$ChapterModelCopyWithImpl;
@override @useResult
$Res call({
 String title, String cid
});




}
/// @nodoc
class __$ChapterModelCopyWithImpl<$Res>
    implements _$ChapterModelCopyWith<$Res> {
  __$ChapterModelCopyWithImpl(this._self, this._then);

  final _ChapterModel _self;
  final $Res Function(_ChapterModel) _then;

/// Create a copy of ChapterModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? cid = null,}) {
  return _then(_ChapterModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,cid: null == cid ? _self.cid : cid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
