// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_bar_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChapterProgress {
  int get chapterIndex => throw _privateConstructorUsedError; // 章节索引
  int get totalPages => throw _privateConstructorUsedError; // 章节总页数
  int get currentIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChapterProgressCopyWith<ChapterProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterProgressCopyWith<$Res> {
  factory $ChapterProgressCopyWith(
          ChapterProgress value, $Res Function(ChapterProgress) then) =
      _$ChapterProgressCopyWithImpl<$Res, ChapterProgress>;
  @useResult
  $Res call({int chapterIndex, int totalPages, int currentIndex});
}

/// @nodoc
class _$ChapterProgressCopyWithImpl<$Res, $Val extends ChapterProgress>
    implements $ChapterProgressCopyWith<$Res> {
  _$ChapterProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chapterIndex = null,
    Object? totalPages = null,
    Object? currentIndex = null,
  }) {
    return _then(_value.copyWith(
      chapterIndex: null == chapterIndex
          ? _value.chapterIndex
          : chapterIndex // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChapterProgressCopyWith<$Res>
    implements $ChapterProgressCopyWith<$Res> {
  factory _$$_ChapterProgressCopyWith(
          _$_ChapterProgress value, $Res Function(_$_ChapterProgress) then) =
      __$$_ChapterProgressCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int chapterIndex, int totalPages, int currentIndex});
}

/// @nodoc
class __$$_ChapterProgressCopyWithImpl<$Res>
    extends _$ChapterProgressCopyWithImpl<$Res, _$_ChapterProgress>
    implements _$$_ChapterProgressCopyWith<$Res> {
  __$$_ChapterProgressCopyWithImpl(
      _$_ChapterProgress _value, $Res Function(_$_ChapterProgress) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chapterIndex = null,
    Object? totalPages = null,
    Object? currentIndex = null,
  }) {
    return _then(_$_ChapterProgress(
      chapterIndex: null == chapterIndex
          ? _value.chapterIndex
          : chapterIndex // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ChapterProgress extends _ChapterProgress {
  const _$_ChapterProgress(
      {required this.chapterIndex,
      required this.totalPages,
      required this.currentIndex})
      : super._();

  @override
  final int chapterIndex;
// 章节索引
  @override
  final int totalPages;
// 章节总页数
  @override
  final int currentIndex;

  @override
  String toString() {
    return 'ChapterProgress(chapterIndex: $chapterIndex, totalPages: $totalPages, currentIndex: $currentIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChapterProgress &&
            (identical(other.chapterIndex, chapterIndex) ||
                other.chapterIndex == chapterIndex) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, chapterIndex, totalPages, currentIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChapterProgressCopyWith<_$_ChapterProgress> get copyWith =>
      __$$_ChapterProgressCopyWithImpl<_$_ChapterProgress>(this, _$identity);
}

abstract class _ChapterProgress extends ChapterProgress {
  const factory _ChapterProgress(
      {required final int chapterIndex,
      required final int totalPages,
      required final int currentIndex}) = _$_ChapterProgress;
  const _ChapterProgress._() : super._();

  @override
  int get chapterIndex;
  @override // 章节索引
  int get totalPages;
  @override // 章节总页数
  int get currentIndex;
  @override
  @JsonKey(ignore: true)
  _$$_ChapterProgressCopyWith<_$_ChapterProgress> get copyWith =>
      throw _privateConstructorUsedError;
}
