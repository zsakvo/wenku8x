// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'download_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BookDownloader {
  String get aid => throw _privateConstructorUsedError;
  BookDownloadStatus get status => throw _privateConstructorUsedError;
  int get cachedNum => throw _privateConstructorUsedError;
  bool get canDownload => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BookDownloaderCopyWith<BookDownloader> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookDownloaderCopyWith<$Res> {
  factory $BookDownloaderCopyWith(
          BookDownloader value, $Res Function(BookDownloader) then) =
      _$BookDownloaderCopyWithImpl<$Res, BookDownloader>;
  @useResult
  $Res call(
      {String aid, BookDownloadStatus status, int cachedNum, bool canDownload});
}

/// @nodoc
class _$BookDownloaderCopyWithImpl<$Res, $Val extends BookDownloader>
    implements $BookDownloaderCopyWith<$Res> {
  _$BookDownloaderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? aid = null,
    Object? status = null,
    Object? cachedNum = null,
    Object? canDownload = null,
  }) {
    return _then(_value.copyWith(
      aid: null == aid
          ? _value.aid
          : aid // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BookDownloadStatus,
      cachedNum: null == cachedNum
          ? _value.cachedNum
          : cachedNum // ignore: cast_nullable_to_non_nullable
              as int,
      canDownload: null == canDownload
          ? _value.canDownload
          : canDownload // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BookDownloaderCopyWith<$Res>
    implements $BookDownloaderCopyWith<$Res> {
  factory _$$_BookDownloaderCopyWith(
          _$_BookDownloader value, $Res Function(_$_BookDownloader) then) =
      __$$_BookDownloaderCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String aid, BookDownloadStatus status, int cachedNum, bool canDownload});
}

/// @nodoc
class __$$_BookDownloaderCopyWithImpl<$Res>
    extends _$BookDownloaderCopyWithImpl<$Res, _$_BookDownloader>
    implements _$$_BookDownloaderCopyWith<$Res> {
  __$$_BookDownloaderCopyWithImpl(
      _$_BookDownloader _value, $Res Function(_$_BookDownloader) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? aid = null,
    Object? status = null,
    Object? cachedNum = null,
    Object? canDownload = null,
  }) {
    return _then(_$_BookDownloader(
      aid: null == aid
          ? _value.aid
          : aid // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BookDownloadStatus,
      cachedNum: null == cachedNum
          ? _value.cachedNum
          : cachedNum // ignore: cast_nullable_to_non_nullable
              as int,
      canDownload: null == canDownload
          ? _value.canDownload
          : canDownload // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_BookDownloader extends _BookDownloader {
  const _$_BookDownloader(
      {required this.aid,
      this.status = BookDownloadStatus.none,
      this.cachedNum = 0,
      this.canDownload = false})
      : super._();

  @override
  final String aid;
  @override
  @JsonKey()
  final BookDownloadStatus status;
  @override
  @JsonKey()
  final int cachedNum;
  @override
  @JsonKey()
  final bool canDownload;

  @override
  String toString() {
    return 'BookDownloader(aid: $aid, status: $status, cachedNum: $cachedNum, canDownload: $canDownload)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BookDownloader &&
            (identical(other.aid, aid) || other.aid == aid) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.cachedNum, cachedNum) ||
                other.cachedNum == cachedNum) &&
            (identical(other.canDownload, canDownload) ||
                other.canDownload == canDownload));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, aid, status, cachedNum, canDownload);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BookDownloaderCopyWith<_$_BookDownloader> get copyWith =>
      __$$_BookDownloaderCopyWithImpl<_$_BookDownloader>(this, _$identity);
}

abstract class _BookDownloader extends BookDownloader {
  const factory _BookDownloader(
      {required final String aid,
      final BookDownloadStatus status,
      final int cachedNum,
      final bool canDownload}) = _$_BookDownloader;
  const _BookDownloader._() : super._();

  @override
  String get aid;
  @override
  BookDownloadStatus get status;
  @override
  int get cachedNum;
  @override
  bool get canDownload;
  @override
  @JsonKey(ignore: true)
  _$$_BookDownloaderCopyWith<_$_BookDownloader> get copyWith =>
      throw _privateConstructorUsedError;
}
