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
  $Res call({String name, String aid, List<Widget> pages});
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CoverReaderCopyWith<$Res>
    implements $CoverReaderCopyWith<$Res> {
  factory _$$_CoverReaderCopyWith(
          _$_CoverReader value, $Res Function(_$_CoverReader) then) =
      __$$_CoverReaderCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String aid, List<Widget> pages});
}

/// @nodoc
class __$$_CoverReaderCopyWithImpl<$Res>
    extends _$CoverReaderCopyWithImpl<$Res, _$_CoverReader>
    implements _$$_CoverReaderCopyWith<$Res> {
  __$$_CoverReaderCopyWithImpl(
      _$_CoverReader _value, $Res Function(_$_CoverReader) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? aid = null,
    Object? pages = null,
  }) {
    return _then(_$_CoverReader(
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
    ));
  }
}

/// @nodoc

class _$_CoverReader extends _CoverReader {
  const _$_CoverReader(
      {required this.name,
      required this.aid,
      final List<Widget> pages = const []})
      : _pages = pages,
        super._();

  @override
  final String name;
  @override
  final String aid;
  final List<Widget> _pages;
  @override
  @JsonKey()
  List<Widget> get pages {
    if (_pages is EqualUnmodifiableListView) return _pages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pages);
  }

  @override
  String toString() {
    return 'CoverReader(name: $name, aid: $aid, pages: $pages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CoverReader &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.aid, aid) || other.aid == aid) &&
            const DeepCollectionEquality().equals(other._pages, _pages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, aid, const DeepCollectionEquality().hash(_pages));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CoverReaderCopyWith<_$_CoverReader> get copyWith =>
      __$$_CoverReaderCopyWithImpl<_$_CoverReader>(this, _$identity);
}

abstract class _CoverReader extends CoverReader {
  const factory _CoverReader(
      {required final String name,
      required final String aid,
      final List<Widget> pages}) = _$_CoverReader;
  const _CoverReader._() : super._();

  @override
  String get name;
  @override
  String get aid;
  @override
  List<Widget> get pages;
  @override
  @JsonKey(ignore: true)
  _$$_CoverReaderCopyWith<_$_CoverReader> get copyWith =>
      throw _privateConstructorUsedError;
}
