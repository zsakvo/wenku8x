// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProgressModel {

 String get bookId; String get chapterId; int get paragraphIndex; int get lineIndex;
/// Create a copy of ProgressModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressModelCopyWith<ProgressModel> get copyWith => _$ProgressModelCopyWithImpl<ProgressModel>(this as ProgressModel, _$identity);

  /// Serializes this ProgressModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressModel&&(identical(other.bookId, bookId) || other.bookId == bookId)&&(identical(other.chapterId, chapterId) || other.chapterId == chapterId)&&(identical(other.paragraphIndex, paragraphIndex) || other.paragraphIndex == paragraphIndex)&&(identical(other.lineIndex, lineIndex) || other.lineIndex == lineIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookId,chapterId,paragraphIndex,lineIndex);

@override
String toString() {
  return 'ProgressModel(bookId: $bookId, chapterId: $chapterId, paragraphIndex: $paragraphIndex, lineIndex: $lineIndex)';
}


}

/// @nodoc
abstract mixin class $ProgressModelCopyWith<$Res>  {
  factory $ProgressModelCopyWith(ProgressModel value, $Res Function(ProgressModel) _then) = _$ProgressModelCopyWithImpl;
@useResult
$Res call({
 String bookId, String chapterId, int paragraphIndex, int lineIndex
});




}
/// @nodoc
class _$ProgressModelCopyWithImpl<$Res>
    implements $ProgressModelCopyWith<$Res> {
  _$ProgressModelCopyWithImpl(this._self, this._then);

  final ProgressModel _self;
  final $Res Function(ProgressModel) _then;

/// Create a copy of ProgressModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookId = null,Object? chapterId = null,Object? paragraphIndex = null,Object? lineIndex = null,}) {
  return _then(_self.copyWith(
bookId: null == bookId ? _self.bookId : bookId // ignore: cast_nullable_to_non_nullable
as String,chapterId: null == chapterId ? _self.chapterId : chapterId // ignore: cast_nullable_to_non_nullable
as String,paragraphIndex: null == paragraphIndex ? _self.paragraphIndex : paragraphIndex // ignore: cast_nullable_to_non_nullable
as int,lineIndex: null == lineIndex ? _self.lineIndex : lineIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ProgressModel extends ProgressModel {
  const _ProgressModel({required this.bookId, required this.chapterId, this.paragraphIndex = 0, this.lineIndex = 0}): super._();
  factory _ProgressModel.fromJson(Map<String, dynamic> json) => _$ProgressModelFromJson(json);

@override final  String bookId;
@override final  String chapterId;
@override@JsonKey() final  int paragraphIndex;
@override@JsonKey() final  int lineIndex;

/// Create a copy of ProgressModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressModelCopyWith<_ProgressModel> get copyWith => __$ProgressModelCopyWithImpl<_ProgressModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgressModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressModel&&(identical(other.bookId, bookId) || other.bookId == bookId)&&(identical(other.chapterId, chapterId) || other.chapterId == chapterId)&&(identical(other.paragraphIndex, paragraphIndex) || other.paragraphIndex == paragraphIndex)&&(identical(other.lineIndex, lineIndex) || other.lineIndex == lineIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookId,chapterId,paragraphIndex,lineIndex);

@override
String toString() {
  return 'ProgressModel(bookId: $bookId, chapterId: $chapterId, paragraphIndex: $paragraphIndex, lineIndex: $lineIndex)';
}


}

/// @nodoc
abstract mixin class _$ProgressModelCopyWith<$Res> implements $ProgressModelCopyWith<$Res> {
  factory _$ProgressModelCopyWith(_ProgressModel value, $Res Function(_ProgressModel) _then) = __$ProgressModelCopyWithImpl;
@override @useResult
$Res call({
 String bookId, String chapterId, int paragraphIndex, int lineIndex
});




}
/// @nodoc
class __$ProgressModelCopyWithImpl<$Res>
    implements _$ProgressModelCopyWith<$Res> {
  __$ProgressModelCopyWithImpl(this._self, this._then);

  final _ProgressModel _self;
  final $Res Function(_ProgressModel) _then;

/// Create a copy of ProgressModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookId = null,Object? chapterId = null,Object? paragraphIndex = null,Object? lineIndex = null,}) {
  return _then(_ProgressModel(
bookId: null == bookId ? _self.bookId : bookId // ignore: cast_nullable_to_non_nullable
as String,chapterId: null == chapterId ? _self.chapterId : chapterId // ignore: cast_nullable_to_non_nullable
as String,paragraphIndex: null == paragraphIndex ? _self.paragraphIndex : paragraphIndex // ignore: cast_nullable_to_non_nullable
as int,lineIndex: null == lineIndex ? _self.lineIndex : lineIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
