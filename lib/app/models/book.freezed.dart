// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookModel {

 String get aid; String get name; String? get author; String? get lastChapter; String? get lastChapterId; String? get lastUpdate; String? get status; String? get intro; int? get dayHitsCount; int? get totalHitsCount; int? get pushCount; int? get favCount; String? get pressId; String? get pressName; int? get length; List<String>? get tags;
/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookModelCopyWith<BookModel> get copyWith => _$BookModelCopyWithImpl<BookModel>(this as BookModel, _$identity);

  /// Serializes this BookModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookModel&&(identical(other.aid, aid) || other.aid == aid)&&(identical(other.name, name) || other.name == name)&&(identical(other.author, author) || other.author == author)&&(identical(other.lastChapter, lastChapter) || other.lastChapter == lastChapter)&&(identical(other.lastChapterId, lastChapterId) || other.lastChapterId == lastChapterId)&&(identical(other.lastUpdate, lastUpdate) || other.lastUpdate == lastUpdate)&&(identical(other.status, status) || other.status == status)&&(identical(other.intro, intro) || other.intro == intro)&&(identical(other.dayHitsCount, dayHitsCount) || other.dayHitsCount == dayHitsCount)&&(identical(other.totalHitsCount, totalHitsCount) || other.totalHitsCount == totalHitsCount)&&(identical(other.pushCount, pushCount) || other.pushCount == pushCount)&&(identical(other.favCount, favCount) || other.favCount == favCount)&&(identical(other.pressId, pressId) || other.pressId == pressId)&&(identical(other.pressName, pressName) || other.pressName == pressName)&&(identical(other.length, length) || other.length == length)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,aid,name,author,lastChapter,lastChapterId,lastUpdate,status,intro,dayHitsCount,totalHitsCount,pushCount,favCount,pressId,pressName,length,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'BookModel(aid: $aid, name: $name, author: $author, lastChapter: $lastChapter, lastChapterId: $lastChapterId, lastUpdate: $lastUpdate, status: $status, intro: $intro, dayHitsCount: $dayHitsCount, totalHitsCount: $totalHitsCount, pushCount: $pushCount, favCount: $favCount, pressId: $pressId, pressName: $pressName, length: $length, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $BookModelCopyWith<$Res>  {
  factory $BookModelCopyWith(BookModel value, $Res Function(BookModel) _then) = _$BookModelCopyWithImpl;
@useResult
$Res call({
 String aid, String name, String? author, String? lastChapter, String? lastChapterId, String? lastUpdate, String? status, String? intro, int? dayHitsCount, int? totalHitsCount, int? pushCount, int? favCount, String? pressId, String? pressName, int? length, List<String>? tags
});




}
/// @nodoc
class _$BookModelCopyWithImpl<$Res>
    implements $BookModelCopyWith<$Res> {
  _$BookModelCopyWithImpl(this._self, this._then);

  final BookModel _self;
  final $Res Function(BookModel) _then;

/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? aid = null,Object? name = null,Object? author = freezed,Object? lastChapter = freezed,Object? lastChapterId = freezed,Object? lastUpdate = freezed,Object? status = freezed,Object? intro = freezed,Object? dayHitsCount = freezed,Object? totalHitsCount = freezed,Object? pushCount = freezed,Object? favCount = freezed,Object? pressId = freezed,Object? pressName = freezed,Object? length = freezed,Object? tags = freezed,}) {
  return _then(_self.copyWith(
aid: null == aid ? _self.aid : aid // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,lastChapter: freezed == lastChapter ? _self.lastChapter : lastChapter // ignore: cast_nullable_to_non_nullable
as String?,lastChapterId: freezed == lastChapterId ? _self.lastChapterId : lastChapterId // ignore: cast_nullable_to_non_nullable
as String?,lastUpdate: freezed == lastUpdate ? _self.lastUpdate : lastUpdate // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,intro: freezed == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as String?,dayHitsCount: freezed == dayHitsCount ? _self.dayHitsCount : dayHitsCount // ignore: cast_nullable_to_non_nullable
as int?,totalHitsCount: freezed == totalHitsCount ? _self.totalHitsCount : totalHitsCount // ignore: cast_nullable_to_non_nullable
as int?,pushCount: freezed == pushCount ? _self.pushCount : pushCount // ignore: cast_nullable_to_non_nullable
as int?,favCount: freezed == favCount ? _self.favCount : favCount // ignore: cast_nullable_to_non_nullable
as int?,pressId: freezed == pressId ? _self.pressId : pressId // ignore: cast_nullable_to_non_nullable
as String?,pressName: freezed == pressName ? _self.pressName : pressName // ignore: cast_nullable_to_non_nullable
as String?,length: freezed == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookModel].
extension BookModelPatterns on BookModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookModel value)  $default,){
final _that = this;
switch (_that) {
case _BookModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String aid,  String name,  String? author,  String? lastChapter,  String? lastChapterId,  String? lastUpdate,  String? status,  String? intro,  int? dayHitsCount,  int? totalHitsCount,  int? pushCount,  int? favCount,  String? pressId,  String? pressName,  int? length,  List<String>? tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookModel() when $default != null:
return $default(_that.aid,_that.name,_that.author,_that.lastChapter,_that.lastChapterId,_that.lastUpdate,_that.status,_that.intro,_that.dayHitsCount,_that.totalHitsCount,_that.pushCount,_that.favCount,_that.pressId,_that.pressName,_that.length,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String aid,  String name,  String? author,  String? lastChapter,  String? lastChapterId,  String? lastUpdate,  String? status,  String? intro,  int? dayHitsCount,  int? totalHitsCount,  int? pushCount,  int? favCount,  String? pressId,  String? pressName,  int? length,  List<String>? tags)  $default,) {final _that = this;
switch (_that) {
case _BookModel():
return $default(_that.aid,_that.name,_that.author,_that.lastChapter,_that.lastChapterId,_that.lastUpdate,_that.status,_that.intro,_that.dayHitsCount,_that.totalHitsCount,_that.pushCount,_that.favCount,_that.pressId,_that.pressName,_that.length,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String aid,  String name,  String? author,  String? lastChapter,  String? lastChapterId,  String? lastUpdate,  String? status,  String? intro,  int? dayHitsCount,  int? totalHitsCount,  int? pushCount,  int? favCount,  String? pressId,  String? pressName,  int? length,  List<String>? tags)?  $default,) {final _that = this;
switch (_that) {
case _BookModel() when $default != null:
return $default(_that.aid,_that.name,_that.author,_that.lastChapter,_that.lastChapterId,_that.lastUpdate,_that.status,_that.intro,_that.dayHitsCount,_that.totalHitsCount,_that.pushCount,_that.favCount,_that.pressId,_that.pressName,_that.length,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookModel extends BookModel {
  const _BookModel({required this.aid, required this.name, this.author, this.lastChapter, this.lastChapterId, this.lastUpdate, this.status, this.intro, this.dayHitsCount, this.totalHitsCount, this.pushCount, this.favCount, this.pressId, this.pressName, this.length, final  List<String>? tags}): _tags = tags,super._();
  factory _BookModel.fromJson(Map<String, dynamic> json) => _$BookModelFromJson(json);

@override final  String aid;
@override final  String name;
@override final  String? author;
@override final  String? lastChapter;
@override final  String? lastChapterId;
@override final  String? lastUpdate;
@override final  String? status;
@override final  String? intro;
@override final  int? dayHitsCount;
@override final  int? totalHitsCount;
@override final  int? pushCount;
@override final  int? favCount;
@override final  String? pressId;
@override final  String? pressName;
@override final  int? length;
 final  List<String>? _tags;
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookModelCopyWith<_BookModel> get copyWith => __$BookModelCopyWithImpl<_BookModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookModel&&(identical(other.aid, aid) || other.aid == aid)&&(identical(other.name, name) || other.name == name)&&(identical(other.author, author) || other.author == author)&&(identical(other.lastChapter, lastChapter) || other.lastChapter == lastChapter)&&(identical(other.lastChapterId, lastChapterId) || other.lastChapterId == lastChapterId)&&(identical(other.lastUpdate, lastUpdate) || other.lastUpdate == lastUpdate)&&(identical(other.status, status) || other.status == status)&&(identical(other.intro, intro) || other.intro == intro)&&(identical(other.dayHitsCount, dayHitsCount) || other.dayHitsCount == dayHitsCount)&&(identical(other.totalHitsCount, totalHitsCount) || other.totalHitsCount == totalHitsCount)&&(identical(other.pushCount, pushCount) || other.pushCount == pushCount)&&(identical(other.favCount, favCount) || other.favCount == favCount)&&(identical(other.pressId, pressId) || other.pressId == pressId)&&(identical(other.pressName, pressName) || other.pressName == pressName)&&(identical(other.length, length) || other.length == length)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,aid,name,author,lastChapter,lastChapterId,lastUpdate,status,intro,dayHitsCount,totalHitsCount,pushCount,favCount,pressId,pressName,length,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'BookModel(aid: $aid, name: $name, author: $author, lastChapter: $lastChapter, lastChapterId: $lastChapterId, lastUpdate: $lastUpdate, status: $status, intro: $intro, dayHitsCount: $dayHitsCount, totalHitsCount: $totalHitsCount, pushCount: $pushCount, favCount: $favCount, pressId: $pressId, pressName: $pressName, length: $length, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$BookModelCopyWith<$Res> implements $BookModelCopyWith<$Res> {
  factory _$BookModelCopyWith(_BookModel value, $Res Function(_BookModel) _then) = __$BookModelCopyWithImpl;
@override @useResult
$Res call({
 String aid, String name, String? author, String? lastChapter, String? lastChapterId, String? lastUpdate, String? status, String? intro, int? dayHitsCount, int? totalHitsCount, int? pushCount, int? favCount, String? pressId, String? pressName, int? length, List<String>? tags
});




}
/// @nodoc
class __$BookModelCopyWithImpl<$Res>
    implements _$BookModelCopyWith<$Res> {
  __$BookModelCopyWithImpl(this._self, this._then);

  final _BookModel _self;
  final $Res Function(_BookModel) _then;

/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? aid = null,Object? name = null,Object? author = freezed,Object? lastChapter = freezed,Object? lastChapterId = freezed,Object? lastUpdate = freezed,Object? status = freezed,Object? intro = freezed,Object? dayHitsCount = freezed,Object? totalHitsCount = freezed,Object? pushCount = freezed,Object? favCount = freezed,Object? pressId = freezed,Object? pressName = freezed,Object? length = freezed,Object? tags = freezed,}) {
  return _then(_BookModel(
aid: null == aid ? _self.aid : aid // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,lastChapter: freezed == lastChapter ? _self.lastChapter : lastChapter // ignore: cast_nullable_to_non_nullable
as String?,lastChapterId: freezed == lastChapterId ? _self.lastChapterId : lastChapterId // ignore: cast_nullable_to_non_nullable
as String?,lastUpdate: freezed == lastUpdate ? _self.lastUpdate : lastUpdate // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,intro: freezed == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as String?,dayHitsCount: freezed == dayHitsCount ? _self.dayHitsCount : dayHitsCount // ignore: cast_nullable_to_non_nullable
as int?,totalHitsCount: freezed == totalHitsCount ? _self.totalHitsCount : totalHitsCount // ignore: cast_nullable_to_non_nullable
as int?,pushCount: freezed == pushCount ? _self.pushCount : pushCount // ignore: cast_nullable_to_non_nullable
as int?,favCount: freezed == favCount ? _self.favCount : favCount // ignore: cast_nullable_to_non_nullable
as int?,pressId: freezed == pressId ? _self.pressId : pressId // ignore: cast_nullable_to_non_nullable
as String?,pressName: freezed == pressName ? _self.pressName : pressName // ignore: cast_nullable_to_non_nullable
as String?,length: freezed == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
