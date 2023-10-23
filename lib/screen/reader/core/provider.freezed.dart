// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReaderCore {
  String get name => throw _privateConstructorUsedError;
  String get aid => throw _privateConstructorUsedError;
  PagesScheduler get pagesScheduler => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  int get cIndex => throw _privateConstructorUsedError;
  String get themeId => throw _privateConstructorUsedError;
  PageConfig get pageConfig => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReaderCoreCopyWith<ReaderCore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReaderCoreCopyWith<$Res> {
  factory $ReaderCoreCopyWith(
          ReaderCore value, $Res Function(ReaderCore) then) =
      _$ReaderCoreCopyWithImpl<$Res, ReaderCore>;
  @useResult
  $Res call(
      {String name,
      String aid,
      PagesScheduler pagesScheduler,
      bool isLoading,
      int cIndex,
      String themeId,
      PageConfig pageConfig});
}

/// @nodoc
class _$ReaderCoreCopyWithImpl<$Res, $Val extends ReaderCore>
    implements $ReaderCoreCopyWith<$Res> {
  _$ReaderCoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? aid = null,
    Object? pagesScheduler = null,
    Object? isLoading = null,
    Object? cIndex = null,
    Object? themeId = null,
    Object? pageConfig = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      aid: null == aid
          ? _value.aid
          : aid // ignore: cast_nullable_to_non_nullable
              as String,
      pagesScheduler: null == pagesScheduler
          ? _value.pagesScheduler
          : pagesScheduler // ignore: cast_nullable_to_non_nullable
              as PagesScheduler,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      cIndex: null == cIndex
          ? _value.cIndex
          : cIndex // ignore: cast_nullable_to_non_nullable
              as int,
      themeId: null == themeId
          ? _value.themeId
          : themeId // ignore: cast_nullable_to_non_nullable
              as String,
      pageConfig: null == pageConfig
          ? _value.pageConfig
          : pageConfig // ignore: cast_nullable_to_non_nullable
              as PageConfig,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReaderCoreCopyWith<$Res>
    implements $ReaderCoreCopyWith<$Res> {
  factory _$$_ReaderCoreCopyWith(
          _$_ReaderCore value, $Res Function(_$_ReaderCore) then) =
      __$$_ReaderCoreCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String aid,
      PagesScheduler pagesScheduler,
      bool isLoading,
      int cIndex,
      String themeId,
      PageConfig pageConfig});
}

/// @nodoc
class __$$_ReaderCoreCopyWithImpl<$Res>
    extends _$ReaderCoreCopyWithImpl<$Res, _$_ReaderCore>
    implements _$$_ReaderCoreCopyWith<$Res> {
  __$$_ReaderCoreCopyWithImpl(
      _$_ReaderCore _value, $Res Function(_$_ReaderCore) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? aid = null,
    Object? pagesScheduler = null,
    Object? isLoading = null,
    Object? cIndex = null,
    Object? themeId = null,
    Object? pageConfig = null,
  }) {
    return _then(_$_ReaderCore(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      aid: null == aid
          ? _value.aid
          : aid // ignore: cast_nullable_to_non_nullable
              as String,
      pagesScheduler: null == pagesScheduler
          ? _value.pagesScheduler
          : pagesScheduler // ignore: cast_nullable_to_non_nullable
              as PagesScheduler,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      cIndex: null == cIndex
          ? _value.cIndex
          : cIndex // ignore: cast_nullable_to_non_nullable
              as int,
      themeId: null == themeId
          ? _value.themeId
          : themeId // ignore: cast_nullable_to_non_nullable
              as String,
      pageConfig: null == pageConfig
          ? _value.pageConfig
          : pageConfig // ignore: cast_nullable_to_non_nullable
              as PageConfig,
    ));
  }
}

/// @nodoc

class _$_ReaderCore extends _ReaderCore {
  const _$_ReaderCore(
      {required this.name,
      required this.aid,
      required this.pagesScheduler,
      this.isLoading = true,
      this.cIndex = 0,
      this.themeId = "mulberry",
      this.pageConfig = const PageConfig()})
      : super._();

  @override
  final String name;
  @override
  final String aid;
  @override
  final PagesScheduler pagesScheduler;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final int cIndex;
  @override
  @JsonKey()
  final String themeId;
  @override
  @JsonKey()
  final PageConfig pageConfig;

  @override
  String toString() {
    return 'ReaderCore(name: $name, aid: $aid, pagesScheduler: $pagesScheduler, isLoading: $isLoading, cIndex: $cIndex, themeId: $themeId, pageConfig: $pageConfig)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReaderCore &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.aid, aid) || other.aid == aid) &&
            (identical(other.pagesScheduler, pagesScheduler) ||
                other.pagesScheduler == pagesScheduler) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.cIndex, cIndex) || other.cIndex == cIndex) &&
            (identical(other.themeId, themeId) || other.themeId == themeId) &&
            (identical(other.pageConfig, pageConfig) ||
                other.pageConfig == pageConfig));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, aid, pagesScheduler,
      isLoading, cIndex, themeId, pageConfig);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReaderCoreCopyWith<_$_ReaderCore> get copyWith =>
      __$$_ReaderCoreCopyWithImpl<_$_ReaderCore>(this, _$identity);
}

abstract class _ReaderCore extends ReaderCore {
  const factory _ReaderCore(
      {required final String name,
      required final String aid,
      required final PagesScheduler pagesScheduler,
      final bool isLoading,
      final int cIndex,
      final String themeId,
      final PageConfig pageConfig}) = _$_ReaderCore;
  const _ReaderCore._() : super._();

  @override
  String get name;
  @override
  String get aid;
  @override
  PagesScheduler get pagesScheduler;
  @override
  bool get isLoading;
  @override
  int get cIndex;
  @override
  String get themeId;
  @override
  PageConfig get pageConfig;
  @override
  @JsonKey(ignore: true)
  _$$_ReaderCoreCopyWith<_$_ReaderCore> get copyWith =>
      throw _privateConstructorUsedError;
}
