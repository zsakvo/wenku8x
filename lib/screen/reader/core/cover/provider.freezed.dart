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
mixin _$CoverReader {
  String get name => throw _privateConstructorUsedError;
  String get aid => throw _privateConstructorUsedError;
  List<Widget> get pages => throw _privateConstructorUsedError;
  int get currentChapter => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  ReaderCore? get readerCore => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CoverReaderCopyWith<CoverReader> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoverReaderCopyWith<$Res> {
  factory $CoverReaderCopyWith(
          CoverReader value, $Res Function(CoverReader) then) =
      _$CoverReaderCopyWithImpl<$Res, CoverReader>;
  @useResult
  $Res call(
      {String name,
      String aid,
      List<Widget> pages,
      int currentChapter,
      int currentPage,
      ReaderCore? readerCore});

  $ReaderCoreCopyWith<$Res>? get readerCore;
}

/// @nodoc
class _$CoverReaderCopyWithImpl<$Res, $Val extends CoverReader>
    implements $CoverReaderCopyWith<$Res> {
  _$CoverReaderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? aid = null,
    Object? pages = null,
    Object? currentChapter = null,
    Object? currentPage = null,
    Object? readerCore = freezed,
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
      pages: null == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<Widget>,
      currentChapter: null == currentChapter
          ? _value.currentChapter
          : currentChapter // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      readerCore: freezed == readerCore
          ? _value.readerCore
          : readerCore // ignore: cast_nullable_to_non_nullable
              as ReaderCore?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ReaderCoreCopyWith<$Res>? get readerCore {
    if (_value.readerCore == null) {
      return null;
    }

    return $ReaderCoreCopyWith<$Res>(_value.readerCore!, (value) {
      return _then(_value.copyWith(readerCore: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CoverReaderImplCopyWith<$Res>
    implements $CoverReaderCopyWith<$Res> {
  factory _$$CoverReaderImplCopyWith(
          _$CoverReaderImpl value, $Res Function(_$CoverReaderImpl) then) =
      __$$CoverReaderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String aid,
      List<Widget> pages,
      int currentChapter,
      int currentPage,
      ReaderCore? readerCore});

  @override
  $ReaderCoreCopyWith<$Res>? get readerCore;
}

/// @nodoc
class __$$CoverReaderImplCopyWithImpl<$Res>
    extends _$CoverReaderCopyWithImpl<$Res, _$CoverReaderImpl>
    implements _$$CoverReaderImplCopyWith<$Res> {
  __$$CoverReaderImplCopyWithImpl(
      _$CoverReaderImpl _value, $Res Function(_$CoverReaderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? aid = null,
    Object? pages = null,
    Object? currentChapter = null,
    Object? currentPage = null,
    Object? readerCore = freezed,
  }) {
    return _then(_$CoverReaderImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      aid: null == aid
          ? _value.aid
          : aid // ignore: cast_nullable_to_non_nullable
              as String,
      pages: null == pages
          ? _value._pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<Widget>,
      currentChapter: null == currentChapter
          ? _value.currentChapter
          : currentChapter // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      readerCore: freezed == readerCore
          ? _value.readerCore
          : readerCore // ignore: cast_nullable_to_non_nullable
              as ReaderCore?,
    ));
  }
}

/// @nodoc

class _$CoverReaderImpl extends _CoverReader {
  const _$CoverReaderImpl(
      {required this.name,
      required this.aid,
      required final List<Widget> pages,
      this.currentChapter = 0,
      this.currentPage = 0,
      this.readerCore})
      : _pages = pages,
        super._();

  @override
  final String name;
  @override
  final String aid;
  final List<Widget> _pages;
  @override
  List<Widget> get pages {
    if (_pages is EqualUnmodifiableListView) return _pages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pages);
  }

  @override
  @JsonKey()
  final int currentChapter;
  @override
  @JsonKey()
  final int currentPage;
  @override
  final ReaderCore? readerCore;

  @override
  String toString() {
    return 'CoverReader(name: $name, aid: $aid, pages: $pages, currentChapter: $currentChapter, currentPage: $currentPage, readerCore: $readerCore)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoverReaderImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.aid, aid) || other.aid == aid) &&
            const DeepCollectionEquality().equals(other._pages, _pages) &&
            (identical(other.currentChapter, currentChapter) ||
                other.currentChapter == currentChapter) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.readerCore, readerCore) ||
                other.readerCore == readerCore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      aid,
      const DeepCollectionEquality().hash(_pages),
      currentChapter,
      currentPage,
      readerCore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CoverReaderImplCopyWith<_$CoverReaderImpl> get copyWith =>
      __$$CoverReaderImplCopyWithImpl<_$CoverReaderImpl>(this, _$identity);
}

abstract class _CoverReader extends CoverReader {
  const factory _CoverReader(
      {required final String name,
      required final String aid,
      required final List<Widget> pages,
      final int currentChapter,
      final int currentPage,
      final ReaderCore? readerCore}) = _$CoverReaderImpl;
  const _CoverReader._() : super._();

  @override
  String get name;
  @override
  String get aid;
  @override
  List<Widget> get pages;
  @override
  int get currentChapter;
  @override
  int get currentPage;
  @override
  ReaderCore? get readerCore;
  @override
  @JsonKey(ignore: true)
  _$$CoverReaderImplCopyWith<_$CoverReaderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
