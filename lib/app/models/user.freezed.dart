// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

 String get rank; int get score; String get nickname; String get uname;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.score, score) || other.score == score)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.uname, uname) || other.uname == uname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rank,score,nickname,uname);

@override
String toString() {
  return 'UserModel(rank: $rank, score: $score, nickname: $nickname, uname: $uname)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String rank, int score, String nickname, String uname
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rank = null,Object? score = null,Object? nickname = null,Object? uname = null,}) {
  return _then(_self.copyWith(
rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,uname: null == uname ? _self.uname : uname // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _UserModel extends UserModel {
  const _UserModel({required this.rank, required this.score, required this.nickname, required this.uname}): super._();
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  String rank;
@override final  int score;
@override final  String nickname;
@override final  String uname;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.score, score) || other.score == score)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.uname, uname) || other.uname == uname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rank,score,nickname,uname);

@override
String toString() {
  return 'UserModel(rank: $rank, score: $score, nickname: $nickname, uname: $uname)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String rank, int score, String nickname, String uname
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rank = null,Object? score = null,Object? nickname = null,Object? uname = null,}) {
  return _then(_UserModel(
rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,uname: null == uname ? _self.uname : uname // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
