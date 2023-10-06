// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rank_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Rank {
  String get flag => throw _privateConstructorUsedError;
  List<BookItem> get books => throw _privateConstructorUsedError;
  int get subIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RankCopyWith<Rank> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RankCopyWith<$Res> {
  factory $RankCopyWith(Rank value, $Res Function(Rank) then) =
      _$RankCopyWithImpl<$Res, Rank>;
  @useResult
  $Res call({String flag, List<BookItem> books, int subIndex});
}

/// @nodoc
class _$RankCopyWithImpl<$Res, $Val extends Rank>
    implements $RankCopyWith<$Res> {
  _$RankCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flag = null,
    Object? books = null,
    Object? subIndex = null,
  }) {
    return _then(_value.copyWith(
      flag: null == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as String,
      books: null == books
          ? _value.books
          : books // ignore: cast_nullable_to_non_nullable
              as List<BookItem>,
      subIndex: null == subIndex
          ? _value.subIndex
          : subIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RankCopyWith<$Res> implements $RankCopyWith<$Res> {
  factory _$$_RankCopyWith(_$_Rank value, $Res Function(_$_Rank) then) =
      __$$_RankCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String flag, List<BookItem> books, int subIndex});
}

/// @nodoc
class __$$_RankCopyWithImpl<$Res> extends _$RankCopyWithImpl<$Res, _$_Rank>
    implements _$$_RankCopyWith<$Res> {
  __$$_RankCopyWithImpl(_$_Rank _value, $Res Function(_$_Rank) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flag = null,
    Object? books = null,
    Object? subIndex = null,
  }) {
    return _then(_$_Rank(
      flag: null == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as String,
      books: null == books
          ? _value._books
          : books // ignore: cast_nullable_to_non_nullable
              as List<BookItem>,
      subIndex: null == subIndex
          ? _value.subIndex
          : subIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Rank extends _Rank {
  const _$_Rank(
      {required this.flag,
      final List<BookItem> books = const [],
      this.subIndex = 0})
      : _books = books,
        super._();

  @override
  final String flag;
  final List<BookItem> _books;
  @override
  @JsonKey()
  List<BookItem> get books {
    if (_books is EqualUnmodifiableListView) return _books;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_books);
  }

  @override
  @JsonKey()
  final int subIndex;

  @override
  String toString() {
    return 'Rank(flag: $flag, books: $books, subIndex: $subIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Rank &&
            (identical(other.flag, flag) || other.flag == flag) &&
            const DeepCollectionEquality().equals(other._books, _books) &&
            (identical(other.subIndex, subIndex) ||
                other.subIndex == subIndex));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, flag, const DeepCollectionEquality().hash(_books), subIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RankCopyWith<_$_Rank> get copyWith =>
      __$$_RankCopyWithImpl<_$_Rank>(this, _$identity);
}

abstract class _Rank extends Rank {
  const factory _Rank(
      {required final String flag,
      final List<BookItem> books,
      final int subIndex}) = _$_Rank;
  const _Rank._() : super._();

  @override
  String get flag;
  @override
  List<BookItem> get books;
  @override
  int get subIndex;
  @override
  @JsonKey(ignore: true)
  _$$_RankCopyWith<_$_Rank> get copyWith => throw _privateConstructorUsedError;
}
