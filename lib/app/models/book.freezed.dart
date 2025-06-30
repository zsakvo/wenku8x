// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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

 String get aid; String get name; String? get author; String? get lastChapter; String? get lastChapterId; String? get lastUpdate; String? get status; String? get intro;
/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookModelCopyWith<BookModel> get copyWith => _$BookModelCopyWithImpl<BookModel>(this as BookModel, _$identity);

  /// Serializes this BookModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookModel&&(identical(other.aid, aid) || other.aid == aid)&&(identical(other.name, name) || other.name == name)&&(identical(other.author, author) || other.author == author)&&(identical(other.lastChapter, lastChapter) || other.lastChapter == lastChapter)&&(identical(other.lastChapterId, lastChapterId) || other.lastChapterId == lastChapterId)&&(identical(other.lastUpdate, lastUpdate) || other.lastUpdate == lastUpdate)&&(identical(other.status, status) || other.status == status)&&(identical(other.intro, intro) || other.intro == intro));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,aid,name,author,lastChapter,lastChapterId,lastUpdate,status,intro);

@override
String toString() {
  return 'BookModel(aid: $aid, name: $name, author: $author, lastChapter: $lastChapter, lastChapterId: $lastChapterId, lastUpdate: $lastUpdate, status: $status, intro: $intro)';
}


}

/// @nodoc
abstract mixin class $BookModelCopyWith<$Res>  {
  factory $BookModelCopyWith(BookModel value, $Res Function(BookModel) _then) = _$BookModelCopyWithImpl;
@useResult
$Res call({
 String aid, String name, String? author, String? lastChapter, String? lastChapterId, String? lastUpdate, String? status, String? intro
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
@pragma('vm:prefer-inline') @override $Res call({Object? aid = null,Object? name = null,Object? author = freezed,Object? lastChapter = freezed,Object? lastChapterId = freezed,Object? lastUpdate = freezed,Object? status = freezed,Object? intro = freezed,}) {
  return _then(_self.copyWith(
aid: null == aid ? _self.aid : aid // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,lastChapter: freezed == lastChapter ? _self.lastChapter : lastChapter // ignore: cast_nullable_to_non_nullable
as String?,lastChapterId: freezed == lastChapterId ? _self.lastChapterId : lastChapterId // ignore: cast_nullable_to_non_nullable
as String?,lastUpdate: freezed == lastUpdate ? _self.lastUpdate : lastUpdate // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,intro: freezed == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _BookModel extends BookModel {
  const _BookModel({required this.aid, required this.name, this.author, this.lastChapter, this.lastChapterId, this.lastUpdate, this.status, this.intro}): super._();
  factory _BookModel.fromJson(Map<String, dynamic> json) => _$BookModelFromJson(json);

@override final  String aid;
@override final  String name;
@override final  String? author;
@override final  String? lastChapter;
@override final  String? lastChapterId;
@override final  String? lastUpdate;
@override final  String? status;
@override final  String? intro;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookModel&&(identical(other.aid, aid) || other.aid == aid)&&(identical(other.name, name) || other.name == name)&&(identical(other.author, author) || other.author == author)&&(identical(other.lastChapter, lastChapter) || other.lastChapter == lastChapter)&&(identical(other.lastChapterId, lastChapterId) || other.lastChapterId == lastChapterId)&&(identical(other.lastUpdate, lastUpdate) || other.lastUpdate == lastUpdate)&&(identical(other.status, status) || other.status == status)&&(identical(other.intro, intro) || other.intro == intro));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,aid,name,author,lastChapter,lastChapterId,lastUpdate,status,intro);

@override
String toString() {
  return 'BookModel(aid: $aid, name: $name, author: $author, lastChapter: $lastChapter, lastChapterId: $lastChapterId, lastUpdate: $lastUpdate, status: $status, intro: $intro)';
}


}

/// @nodoc
abstract mixin class _$BookModelCopyWith<$Res> implements $BookModelCopyWith<$Res> {
  factory _$BookModelCopyWith(_BookModel value, $Res Function(_BookModel) _then) = __$BookModelCopyWithImpl;
@override @useResult
$Res call({
 String aid, String name, String? author, String? lastChapter, String? lastChapterId, String? lastUpdate, String? status, String? intro
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
@override @pragma('vm:prefer-inline') $Res call({Object? aid = null,Object? name = null,Object? author = freezed,Object? lastChapter = freezed,Object? lastChapterId = freezed,Object? lastUpdate = freezed,Object? status = freezed,Object? intro = freezed,}) {
  return _then(_BookModel(
aid: null == aid ? _self.aid : aid // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,lastChapter: freezed == lastChapter ? _self.lastChapter : lastChapter // ignore: cast_nullable_to_non_nullable
as String?,lastChapterId: freezed == lastChapterId ? _self.lastChapterId : lastChapterId // ignore: cast_nullable_to_non_nullable
as String?,lastUpdate: freezed == lastUpdate ? _self.lastUpdate : lastUpdate // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,intro: freezed == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
