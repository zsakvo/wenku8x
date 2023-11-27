// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reader_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Chapter _$ChapterFromJson(Map<String, dynamic> json) {
  return _Chapter.fromJson(json);
}

/// @nodoc
mixin _$Chapter {
  String get cid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChapterCopyWith<Chapter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterCopyWith<$Res> {
  factory $ChapterCopyWith(Chapter value, $Res Function(Chapter) then) =
      _$ChapterCopyWithImpl<$Res, Chapter>;
  @useResult
  $Res call({String cid, String name});
}

/// @nodoc
class _$ChapterCopyWithImpl<$Res, $Val extends Chapter>
    implements $ChapterCopyWith<$Res> {
  _$ChapterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cid = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      cid: null == cid
          ? _value.cid
          : cid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChapterImplCopyWith<$Res> implements $ChapterCopyWith<$Res> {
  factory _$$ChapterImplCopyWith(
          _$ChapterImpl value, $Res Function(_$ChapterImpl) then) =
      __$$ChapterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String cid, String name});
}

/// @nodoc
class __$$ChapterImplCopyWithImpl<$Res>
    extends _$ChapterCopyWithImpl<$Res, _$ChapterImpl>
    implements _$$ChapterImplCopyWith<$Res> {
  __$$ChapterImplCopyWithImpl(
      _$ChapterImpl _value, $Res Function(_$ChapterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cid = null,
    Object? name = null,
  }) {
    return _then(_$ChapterImpl(
      cid: null == cid
          ? _value.cid
          : cid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChapterImpl with DiagnosticableTreeMixin implements _Chapter {
  const _$ChapterImpl({required this.cid, required this.name});

  factory _$ChapterImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChapterImplFromJson(json);

  @override
  final String cid;
  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Chapter(cid: $cid, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Chapter'))
      ..add(DiagnosticsProperty('cid', cid))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChapterImpl &&
            (identical(other.cid, cid) || other.cid == cid) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cid, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChapterImplCopyWith<_$ChapterImpl> get copyWith =>
      __$$ChapterImplCopyWithImpl<_$ChapterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChapterImplToJson(
      this,
    );
  }
}

abstract class _Chapter implements Chapter {
  const factory _Chapter(
      {required final String cid, required final String name}) = _$ChapterImpl;

  factory _Chapter.fromJson(Map<String, dynamic> json) = _$ChapterImpl.fromJson;

  @override
  String get cid;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$ChapterImplCopyWith<_$ChapterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReaderMenuState {
  bool get menuBottomVisible => throw _privateConstructorUsedError;
  bool get menuTopVisible => throw _privateConstructorUsedError;
  bool get menuCatalogVisible => throw _privateConstructorUsedError;
  bool get menuThemeVisible => throw _privateConstructorUsedError;
  bool get menuTextVisible => throw _privateConstructorUsedError;
  bool get menuConfigVisible => throw _privateConstructorUsedError;
  bool get progressVisible => throw _privateConstructorUsedError;
  double get bottomBarHeight => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReaderMenuStateCopyWith<ReaderMenuState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReaderMenuStateCopyWith<$Res> {
  factory $ReaderMenuStateCopyWith(
          ReaderMenuState value, $Res Function(ReaderMenuState) then) =
      _$ReaderMenuStateCopyWithImpl<$Res, ReaderMenuState>;
  @useResult
  $Res call(
      {bool menuBottomVisible,
      bool menuTopVisible,
      bool menuCatalogVisible,
      bool menuThemeVisible,
      bool menuTextVisible,
      bool menuConfigVisible,
      bool progressVisible,
      double bottomBarHeight});
}

/// @nodoc
class _$ReaderMenuStateCopyWithImpl<$Res, $Val extends ReaderMenuState>
    implements $ReaderMenuStateCopyWith<$Res> {
  _$ReaderMenuStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuBottomVisible = null,
    Object? menuTopVisible = null,
    Object? menuCatalogVisible = null,
    Object? menuThemeVisible = null,
    Object? menuTextVisible = null,
    Object? menuConfigVisible = null,
    Object? progressVisible = null,
    Object? bottomBarHeight = null,
  }) {
    return _then(_value.copyWith(
      menuBottomVisible: null == menuBottomVisible
          ? _value.menuBottomVisible
          : menuBottomVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      menuTopVisible: null == menuTopVisible
          ? _value.menuTopVisible
          : menuTopVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      menuCatalogVisible: null == menuCatalogVisible
          ? _value.menuCatalogVisible
          : menuCatalogVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      menuThemeVisible: null == menuThemeVisible
          ? _value.menuThemeVisible
          : menuThemeVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      menuTextVisible: null == menuTextVisible
          ? _value.menuTextVisible
          : menuTextVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      menuConfigVisible: null == menuConfigVisible
          ? _value.menuConfigVisible
          : menuConfigVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      progressVisible: null == progressVisible
          ? _value.progressVisible
          : progressVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      bottomBarHeight: null == bottomBarHeight
          ? _value.bottomBarHeight
          : bottomBarHeight // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReaderMenuStateImplCopyWith<$Res>
    implements $ReaderMenuStateCopyWith<$Res> {
  factory _$$ReaderMenuStateImplCopyWith(_$ReaderMenuStateImpl value,
          $Res Function(_$ReaderMenuStateImpl) then) =
      __$$ReaderMenuStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool menuBottomVisible,
      bool menuTopVisible,
      bool menuCatalogVisible,
      bool menuThemeVisible,
      bool menuTextVisible,
      bool menuConfigVisible,
      bool progressVisible,
      double bottomBarHeight});
}

/// @nodoc
class __$$ReaderMenuStateImplCopyWithImpl<$Res>
    extends _$ReaderMenuStateCopyWithImpl<$Res, _$ReaderMenuStateImpl>
    implements _$$ReaderMenuStateImplCopyWith<$Res> {
  __$$ReaderMenuStateImplCopyWithImpl(
      _$ReaderMenuStateImpl _value, $Res Function(_$ReaderMenuStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuBottomVisible = null,
    Object? menuTopVisible = null,
    Object? menuCatalogVisible = null,
    Object? menuThemeVisible = null,
    Object? menuTextVisible = null,
    Object? menuConfigVisible = null,
    Object? progressVisible = null,
    Object? bottomBarHeight = null,
  }) {
    return _then(_$ReaderMenuStateImpl(
      menuBottomVisible: null == menuBottomVisible
          ? _value.menuBottomVisible
          : menuBottomVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      menuTopVisible: null == menuTopVisible
          ? _value.menuTopVisible
          : menuTopVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      menuCatalogVisible: null == menuCatalogVisible
          ? _value.menuCatalogVisible
          : menuCatalogVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      menuThemeVisible: null == menuThemeVisible
          ? _value.menuThemeVisible
          : menuThemeVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      menuTextVisible: null == menuTextVisible
          ? _value.menuTextVisible
          : menuTextVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      menuConfigVisible: null == menuConfigVisible
          ? _value.menuConfigVisible
          : menuConfigVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      progressVisible: null == progressVisible
          ? _value.progressVisible
          : progressVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      bottomBarHeight: null == bottomBarHeight
          ? _value.bottomBarHeight
          : bottomBarHeight // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$ReaderMenuStateImpl extends _ReaderMenuState
    with DiagnosticableTreeMixin {
  const _$ReaderMenuStateImpl(
      {this.menuBottomVisible = false,
      this.menuTopVisible = false,
      this.menuCatalogVisible = false,
      this.menuThemeVisible = false,
      this.menuTextVisible = false,
      this.menuConfigVisible = false,
      this.progressVisible = false,
      this.bottomBarHeight = 0})
      : super._();

  @override
  @JsonKey()
  final bool menuBottomVisible;
  @override
  @JsonKey()
  final bool menuTopVisible;
  @override
  @JsonKey()
  final bool menuCatalogVisible;
  @override
  @JsonKey()
  final bool menuThemeVisible;
  @override
  @JsonKey()
  final bool menuTextVisible;
  @override
  @JsonKey()
  final bool menuConfigVisible;
  @override
  @JsonKey()
  final bool progressVisible;
  @override
  @JsonKey()
  final double bottomBarHeight;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReaderMenuState(menuBottomVisible: $menuBottomVisible, menuTopVisible: $menuTopVisible, menuCatalogVisible: $menuCatalogVisible, menuThemeVisible: $menuThemeVisible, menuTextVisible: $menuTextVisible, menuConfigVisible: $menuConfigVisible, progressVisible: $progressVisible, bottomBarHeight: $bottomBarHeight)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReaderMenuState'))
      ..add(DiagnosticsProperty('menuBottomVisible', menuBottomVisible))
      ..add(DiagnosticsProperty('menuTopVisible', menuTopVisible))
      ..add(DiagnosticsProperty('menuCatalogVisible', menuCatalogVisible))
      ..add(DiagnosticsProperty('menuThemeVisible', menuThemeVisible))
      ..add(DiagnosticsProperty('menuTextVisible', menuTextVisible))
      ..add(DiagnosticsProperty('menuConfigVisible', menuConfigVisible))
      ..add(DiagnosticsProperty('progressVisible', progressVisible))
      ..add(DiagnosticsProperty('bottomBarHeight', bottomBarHeight));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReaderMenuStateImpl &&
            (identical(other.menuBottomVisible, menuBottomVisible) ||
                other.menuBottomVisible == menuBottomVisible) &&
            (identical(other.menuTopVisible, menuTopVisible) ||
                other.menuTopVisible == menuTopVisible) &&
            (identical(other.menuCatalogVisible, menuCatalogVisible) ||
                other.menuCatalogVisible == menuCatalogVisible) &&
            (identical(other.menuThemeVisible, menuThemeVisible) ||
                other.menuThemeVisible == menuThemeVisible) &&
            (identical(other.menuTextVisible, menuTextVisible) ||
                other.menuTextVisible == menuTextVisible) &&
            (identical(other.menuConfigVisible, menuConfigVisible) ||
                other.menuConfigVisible == menuConfigVisible) &&
            (identical(other.progressVisible, progressVisible) ||
                other.progressVisible == progressVisible) &&
            (identical(other.bottomBarHeight, bottomBarHeight) ||
                other.bottomBarHeight == bottomBarHeight));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      menuBottomVisible,
      menuTopVisible,
      menuCatalogVisible,
      menuThemeVisible,
      menuTextVisible,
      menuConfigVisible,
      progressVisible,
      bottomBarHeight);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReaderMenuStateImplCopyWith<_$ReaderMenuStateImpl> get copyWith =>
      __$$ReaderMenuStateImplCopyWithImpl<_$ReaderMenuStateImpl>(
          this, _$identity);
}

abstract class _ReaderMenuState extends ReaderMenuState {
  const factory _ReaderMenuState(
      {final bool menuBottomVisible,
      final bool menuTopVisible,
      final bool menuCatalogVisible,
      final bool menuThemeVisible,
      final bool menuTextVisible,
      final bool menuConfigVisible,
      final bool progressVisible,
      final double bottomBarHeight}) = _$ReaderMenuStateImpl;
  const _ReaderMenuState._() : super._();

  @override
  bool get menuBottomVisible;
  @override
  bool get menuTopVisible;
  @override
  bool get menuCatalogVisible;
  @override
  bool get menuThemeVisible;
  @override
  bool get menuTextVisible;
  @override
  bool get menuConfigVisible;
  @override
  bool get progressVisible;
  @override
  double get bottomBarHeight;
  @override
  @JsonKey(ignore: true)
  _$$ReaderMenuStateImplCopyWith<_$ReaderMenuStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Reader {
  String get name => throw _privateConstructorUsedError;
  String get aid => throw _privateConstructorUsedError;
  int get cIndex => throw _privateConstructorUsedError;
  String get themeId => throw _privateConstructorUsedError;
  List<Chapter> get catalog => throw _privateConstructorUsedError;
  TextStyle get textStyle => throw _privateConstructorUsedError;
  List<Widget> get pages => throw _privateConstructorUsedError;
  String get cachedText => throw _privateConstructorUsedError;
  ReaderConfig get config => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReaderCopyWith<Reader> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReaderCopyWith<$Res> {
  factory $ReaderCopyWith(Reader value, $Res Function(Reader) then) =
      _$ReaderCopyWithImpl<$Res, Reader>;
  @useResult
  $Res call(
      {String name,
      String aid,
      int cIndex,
      String themeId,
      List<Chapter> catalog,
      TextStyle textStyle,
      List<Widget> pages,
      String cachedText,
      ReaderConfig config});

  $ReaderConfigCopyWith<$Res> get config;
}

/// @nodoc
class _$ReaderCopyWithImpl<$Res, $Val extends Reader>
    implements $ReaderCopyWith<$Res> {
  _$ReaderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? aid = null,
    Object? cIndex = null,
    Object? themeId = null,
    Object? catalog = null,
    Object? textStyle = null,
    Object? pages = null,
    Object? cachedText = null,
    Object? config = null,
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
      cIndex: null == cIndex
          ? _value.cIndex
          : cIndex // ignore: cast_nullable_to_non_nullable
              as int,
      themeId: null == themeId
          ? _value.themeId
          : themeId // ignore: cast_nullable_to_non_nullable
              as String,
      catalog: null == catalog
          ? _value.catalog
          : catalog // ignore: cast_nullable_to_non_nullable
              as List<Chapter>,
      textStyle: null == textStyle
          ? _value.textStyle
          : textStyle // ignore: cast_nullable_to_non_nullable
              as TextStyle,
      pages: null == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<Widget>,
      cachedText: null == cachedText
          ? _value.cachedText
          : cachedText // ignore: cast_nullable_to_non_nullable
              as String,
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as ReaderConfig,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ReaderConfigCopyWith<$Res> get config {
    return $ReaderConfigCopyWith<$Res>(_value.config, (value) {
      return _then(_value.copyWith(config: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReaderImplCopyWith<$Res> implements $ReaderCopyWith<$Res> {
  factory _$$ReaderImplCopyWith(
          _$ReaderImpl value, $Res Function(_$ReaderImpl) then) =
      __$$ReaderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String aid,
      int cIndex,
      String themeId,
      List<Chapter> catalog,
      TextStyle textStyle,
      List<Widget> pages,
      String cachedText,
      ReaderConfig config});

  @override
  $ReaderConfigCopyWith<$Res> get config;
}

/// @nodoc
class __$$ReaderImplCopyWithImpl<$Res>
    extends _$ReaderCopyWithImpl<$Res, _$ReaderImpl>
    implements _$$ReaderImplCopyWith<$Res> {
  __$$ReaderImplCopyWithImpl(
      _$ReaderImpl _value, $Res Function(_$ReaderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? aid = null,
    Object? cIndex = null,
    Object? themeId = null,
    Object? catalog = null,
    Object? textStyle = null,
    Object? pages = null,
    Object? cachedText = null,
    Object? config = null,
  }) {
    return _then(_$ReaderImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      aid: null == aid
          ? _value.aid
          : aid // ignore: cast_nullable_to_non_nullable
              as String,
      cIndex: null == cIndex
          ? _value.cIndex
          : cIndex // ignore: cast_nullable_to_non_nullable
              as int,
      themeId: null == themeId
          ? _value.themeId
          : themeId // ignore: cast_nullable_to_non_nullable
              as String,
      catalog: null == catalog
          ? _value._catalog
          : catalog // ignore: cast_nullable_to_non_nullable
              as List<Chapter>,
      textStyle: null == textStyle
          ? _value.textStyle
          : textStyle // ignore: cast_nullable_to_non_nullable
              as TextStyle,
      pages: null == pages
          ? _value._pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<Widget>,
      cachedText: null == cachedText
          ? _value.cachedText
          : cachedText // ignore: cast_nullable_to_non_nullable
              as String,
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as ReaderConfig,
    ));
  }
}

/// @nodoc

class _$ReaderImpl extends _Reader with DiagnosticableTreeMixin {
  const _$ReaderImpl(
      {required this.name,
      required this.aid,
      this.cIndex = 0,
      this.themeId = "mulberry",
      final List<Chapter> catalog = const [],
      this.textStyle = const TextStyle(fontSize: 18, height: 1.7),
      final List<Widget> pages = const [],
      this.cachedText = "",
      this.config = const ReaderConfig()})
      : _catalog = catalog,
        _pages = pages,
        super._();

  @override
  final String name;
  @override
  final String aid;
  @override
  @JsonKey()
  final int cIndex;
  @override
  @JsonKey()
  final String themeId;
  final List<Chapter> _catalog;
  @override
  @JsonKey()
  List<Chapter> get catalog {
    if (_catalog is EqualUnmodifiableListView) return _catalog;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_catalog);
  }

  @override
  @JsonKey()
  final TextStyle textStyle;
  final List<Widget> _pages;
  @override
  @JsonKey()
  List<Widget> get pages {
    if (_pages is EqualUnmodifiableListView) return _pages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pages);
  }

  @override
  @JsonKey()
  final String cachedText;
  @override
  @JsonKey()
  final ReaderConfig config;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Reader(name: $name, aid: $aid, cIndex: $cIndex, themeId: $themeId, catalog: $catalog, textStyle: $textStyle, pages: $pages, cachedText: $cachedText, config: $config)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Reader'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('aid', aid))
      ..add(DiagnosticsProperty('cIndex', cIndex))
      ..add(DiagnosticsProperty('themeId', themeId))
      ..add(DiagnosticsProperty('catalog', catalog))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('pages', pages))
      ..add(DiagnosticsProperty('cachedText', cachedText))
      ..add(DiagnosticsProperty('config', config));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReaderImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.aid, aid) || other.aid == aid) &&
            (identical(other.cIndex, cIndex) || other.cIndex == cIndex) &&
            (identical(other.themeId, themeId) || other.themeId == themeId) &&
            const DeepCollectionEquality().equals(other._catalog, _catalog) &&
            (identical(other.textStyle, textStyle) ||
                other.textStyle == textStyle) &&
            const DeepCollectionEquality().equals(other._pages, _pages) &&
            (identical(other.cachedText, cachedText) ||
                other.cachedText == cachedText) &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      aid,
      cIndex,
      themeId,
      const DeepCollectionEquality().hash(_catalog),
      textStyle,
      const DeepCollectionEquality().hash(_pages),
      cachedText,
      config);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReaderImplCopyWith<_$ReaderImpl> get copyWith =>
      __$$ReaderImplCopyWithImpl<_$ReaderImpl>(this, _$identity);
}

abstract class _Reader extends Reader {
  const factory _Reader(
      {required final String name,
      required final String aid,
      final int cIndex,
      final String themeId,
      final List<Chapter> catalog,
      final TextStyle textStyle,
      final List<Widget> pages,
      final String cachedText,
      final ReaderConfig config}) = _$ReaderImpl;
  const _Reader._() : super._();

  @override
  String get name;
  @override
  String get aid;
  @override
  int get cIndex;
  @override
  String get themeId;
  @override
  List<Chapter> get catalog;
  @override
  TextStyle get textStyle;
  @override
  List<Widget> get pages;
  @override
  String get cachedText;
  @override
  ReaderConfig get config;
  @override
  @JsonKey(ignore: true)
  _$$ReaderImplCopyWith<_$ReaderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReaderTheme {
  String get name => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  ThemeData get theme => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReaderThemeCopyWith<ReaderTheme> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReaderThemeCopyWith<$Res> {
  factory $ReaderThemeCopyWith(
          ReaderTheme value, $Res Function(ReaderTheme) then) =
      _$ReaderThemeCopyWithImpl<$Res, ReaderTheme>;
  @useResult
  $Res call({String name, String id, ThemeData theme});
}

/// @nodoc
class _$ReaderThemeCopyWithImpl<$Res, $Val extends ReaderTheme>
    implements $ReaderThemeCopyWith<$Res> {
  _$ReaderThemeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? theme = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as ThemeData,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReaderThemeImplCopyWith<$Res>
    implements $ReaderThemeCopyWith<$Res> {
  factory _$$ReaderThemeImplCopyWith(
          _$ReaderThemeImpl value, $Res Function(_$ReaderThemeImpl) then) =
      __$$ReaderThemeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String id, ThemeData theme});
}

/// @nodoc
class __$$ReaderThemeImplCopyWithImpl<$Res>
    extends _$ReaderThemeCopyWithImpl<$Res, _$ReaderThemeImpl>
    implements _$$ReaderThemeImplCopyWith<$Res> {
  __$$ReaderThemeImplCopyWithImpl(
      _$ReaderThemeImpl _value, $Res Function(_$ReaderThemeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? theme = null,
  }) {
    return _then(_$ReaderThemeImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as ThemeData,
    ));
  }
}

/// @nodoc

class _$ReaderThemeImpl with DiagnosticableTreeMixin implements _ReaderTheme {
  const _$ReaderThemeImpl(
      {required this.name, required this.id, required this.theme});

  @override
  final String name;
  @override
  final String id;
  @override
  final ThemeData theme;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReaderTheme(name: $name, id: $id, theme: $theme)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReaderTheme'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('theme', theme));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReaderThemeImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.theme, theme) || other.theme == theme));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, id, theme);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReaderThemeImplCopyWith<_$ReaderThemeImpl> get copyWith =>
      __$$ReaderThemeImplCopyWithImpl<_$ReaderThemeImpl>(this, _$identity);
}

abstract class _ReaderTheme implements ReaderTheme {
  const factory _ReaderTheme(
      {required final String name,
      required final String id,
      required final ThemeData theme}) = _$ReaderThemeImpl;

  @override
  String get name;
  @override
  String get id;
  @override
  ThemeData get theme;
  @override
  @JsonKey(ignore: true)
  _$$ReaderThemeImplCopyWith<_$ReaderThemeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReaderConfig {
  bool get horizontalScroll => throw _privateConstructorUsedError; // 平移翻页
  bool get verticalScroll => throw _privateConstructorUsedError; // 滚动翻页
  bool get flickScroll => throw _privateConstructorUsedError; // 静止翻页
  bool get simulationScroll => throw _privateConstructorUsedError; // 仿真翻页
  bool get buttonScroll => throw _privateConstructorUsedError; // 音量键翻页
  bool get globalNext => throw _privateConstructorUsedError; // 全局下一页
  bool get fullScreen => throw _privateConstructorUsedError; // 全屏显示
  bool get keepScreenOn => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReaderConfigCopyWith<ReaderConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReaderConfigCopyWith<$Res> {
  factory $ReaderConfigCopyWith(
          ReaderConfig value, $Res Function(ReaderConfig) then) =
      _$ReaderConfigCopyWithImpl<$Res, ReaderConfig>;
  @useResult
  $Res call(
      {bool horizontalScroll,
      bool verticalScroll,
      bool flickScroll,
      bool simulationScroll,
      bool buttonScroll,
      bool globalNext,
      bool fullScreen,
      bool keepScreenOn});
}

/// @nodoc
class _$ReaderConfigCopyWithImpl<$Res, $Val extends ReaderConfig>
    implements $ReaderConfigCopyWith<$Res> {
  _$ReaderConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? horizontalScroll = null,
    Object? verticalScroll = null,
    Object? flickScroll = null,
    Object? simulationScroll = null,
    Object? buttonScroll = null,
    Object? globalNext = null,
    Object? fullScreen = null,
    Object? keepScreenOn = null,
  }) {
    return _then(_value.copyWith(
      horizontalScroll: null == horizontalScroll
          ? _value.horizontalScroll
          : horizontalScroll // ignore: cast_nullable_to_non_nullable
              as bool,
      verticalScroll: null == verticalScroll
          ? _value.verticalScroll
          : verticalScroll // ignore: cast_nullable_to_non_nullable
              as bool,
      flickScroll: null == flickScroll
          ? _value.flickScroll
          : flickScroll // ignore: cast_nullable_to_non_nullable
              as bool,
      simulationScroll: null == simulationScroll
          ? _value.simulationScroll
          : simulationScroll // ignore: cast_nullable_to_non_nullable
              as bool,
      buttonScroll: null == buttonScroll
          ? _value.buttonScroll
          : buttonScroll // ignore: cast_nullable_to_non_nullable
              as bool,
      globalNext: null == globalNext
          ? _value.globalNext
          : globalNext // ignore: cast_nullable_to_non_nullable
              as bool,
      fullScreen: null == fullScreen
          ? _value.fullScreen
          : fullScreen // ignore: cast_nullable_to_non_nullable
              as bool,
      keepScreenOn: null == keepScreenOn
          ? _value.keepScreenOn
          : keepScreenOn // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReaderConfigImplCopyWith<$Res>
    implements $ReaderConfigCopyWith<$Res> {
  factory _$$ReaderConfigImplCopyWith(
          _$ReaderConfigImpl value, $Res Function(_$ReaderConfigImpl) then) =
      __$$ReaderConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool horizontalScroll,
      bool verticalScroll,
      bool flickScroll,
      bool simulationScroll,
      bool buttonScroll,
      bool globalNext,
      bool fullScreen,
      bool keepScreenOn});
}

/// @nodoc
class __$$ReaderConfigImplCopyWithImpl<$Res>
    extends _$ReaderConfigCopyWithImpl<$Res, _$ReaderConfigImpl>
    implements _$$ReaderConfigImplCopyWith<$Res> {
  __$$ReaderConfigImplCopyWithImpl(
      _$ReaderConfigImpl _value, $Res Function(_$ReaderConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? horizontalScroll = null,
    Object? verticalScroll = null,
    Object? flickScroll = null,
    Object? simulationScroll = null,
    Object? buttonScroll = null,
    Object? globalNext = null,
    Object? fullScreen = null,
    Object? keepScreenOn = null,
  }) {
    return _then(_$ReaderConfigImpl(
      horizontalScroll: null == horizontalScroll
          ? _value.horizontalScroll
          : horizontalScroll // ignore: cast_nullable_to_non_nullable
              as bool,
      verticalScroll: null == verticalScroll
          ? _value.verticalScroll
          : verticalScroll // ignore: cast_nullable_to_non_nullable
              as bool,
      flickScroll: null == flickScroll
          ? _value.flickScroll
          : flickScroll // ignore: cast_nullable_to_non_nullable
              as bool,
      simulationScroll: null == simulationScroll
          ? _value.simulationScroll
          : simulationScroll // ignore: cast_nullable_to_non_nullable
              as bool,
      buttonScroll: null == buttonScroll
          ? _value.buttonScroll
          : buttonScroll // ignore: cast_nullable_to_non_nullable
              as bool,
      globalNext: null == globalNext
          ? _value.globalNext
          : globalNext // ignore: cast_nullable_to_non_nullable
              as bool,
      fullScreen: null == fullScreen
          ? _value.fullScreen
          : fullScreen // ignore: cast_nullable_to_non_nullable
              as bool,
      keepScreenOn: null == keepScreenOn
          ? _value.keepScreenOn
          : keepScreenOn // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ReaderConfigImpl with DiagnosticableTreeMixin implements _ReaderConfig {
  const _$ReaderConfigImpl(
      {this.horizontalScroll = true,
      this.verticalScroll = false,
      this.flickScroll = false,
      this.simulationScroll = false,
      this.buttonScroll = false,
      this.globalNext = false,
      this.fullScreen = false,
      this.keepScreenOn = false});

  @override
  @JsonKey()
  final bool horizontalScroll;
// 平移翻页
  @override
  @JsonKey()
  final bool verticalScroll;
// 滚动翻页
  @override
  @JsonKey()
  final bool flickScroll;
// 静止翻页
  @override
  @JsonKey()
  final bool simulationScroll;
// 仿真翻页
  @override
  @JsonKey()
  final bool buttonScroll;
// 音量键翻页
  @override
  @JsonKey()
  final bool globalNext;
// 全局下一页
  @override
  @JsonKey()
  final bool fullScreen;
// 全屏显示
  @override
  @JsonKey()
  final bool keepScreenOn;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReaderConfig(horizontalScroll: $horizontalScroll, verticalScroll: $verticalScroll, flickScroll: $flickScroll, simulationScroll: $simulationScroll, buttonScroll: $buttonScroll, globalNext: $globalNext, fullScreen: $fullScreen, keepScreenOn: $keepScreenOn)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReaderConfig'))
      ..add(DiagnosticsProperty('horizontalScroll', horizontalScroll))
      ..add(DiagnosticsProperty('verticalScroll', verticalScroll))
      ..add(DiagnosticsProperty('flickScroll', flickScroll))
      ..add(DiagnosticsProperty('simulationScroll', simulationScroll))
      ..add(DiagnosticsProperty('buttonScroll', buttonScroll))
      ..add(DiagnosticsProperty('globalNext', globalNext))
      ..add(DiagnosticsProperty('fullScreen', fullScreen))
      ..add(DiagnosticsProperty('keepScreenOn', keepScreenOn));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReaderConfigImpl &&
            (identical(other.horizontalScroll, horizontalScroll) ||
                other.horizontalScroll == horizontalScroll) &&
            (identical(other.verticalScroll, verticalScroll) ||
                other.verticalScroll == verticalScroll) &&
            (identical(other.flickScroll, flickScroll) ||
                other.flickScroll == flickScroll) &&
            (identical(other.simulationScroll, simulationScroll) ||
                other.simulationScroll == simulationScroll) &&
            (identical(other.buttonScroll, buttonScroll) ||
                other.buttonScroll == buttonScroll) &&
            (identical(other.globalNext, globalNext) ||
                other.globalNext == globalNext) &&
            (identical(other.fullScreen, fullScreen) ||
                other.fullScreen == fullScreen) &&
            (identical(other.keepScreenOn, keepScreenOn) ||
                other.keepScreenOn == keepScreenOn));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      horizontalScroll,
      verticalScroll,
      flickScroll,
      simulationScroll,
      buttonScroll,
      globalNext,
      fullScreen,
      keepScreenOn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReaderConfigImplCopyWith<_$ReaderConfigImpl> get copyWith =>
      __$$ReaderConfigImplCopyWithImpl<_$ReaderConfigImpl>(this, _$identity);
}

abstract class _ReaderConfig implements ReaderConfig {
  const factory _ReaderConfig(
      {final bool horizontalScroll,
      final bool verticalScroll,
      final bool flickScroll,
      final bool simulationScroll,
      final bool buttonScroll,
      final bool globalNext,
      final bool fullScreen,
      final bool keepScreenOn}) = _$ReaderConfigImpl;

  @override
  bool get horizontalScroll;
  @override // 平移翻页
  bool get verticalScroll;
  @override // 滚动翻页
  bool get flickScroll;
  @override // 静止翻页
  bool get simulationScroll;
  @override // 仿真翻页
  bool get buttonScroll;
  @override // 音量键翻页
  bool get globalNext;
  @override // 全局下一页
  bool get fullScreen;
  @override // 全屏显示
  bool get keepScreenOn;
  @override
  @JsonKey(ignore: true)
  _$$ReaderConfigImplCopyWith<_$ReaderConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecordMeta _$RecordMetaFromJson(Map<String, dynamic> json) {
  return _RecordMeta.fromJson(json);
}

/// @nodoc
mixin _$RecordMeta {
  int get cIndex => throw _privateConstructorUsedError;
  int get pIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecordMetaCopyWith<RecordMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordMetaCopyWith<$Res> {
  factory $RecordMetaCopyWith(
          RecordMeta value, $Res Function(RecordMeta) then) =
      _$RecordMetaCopyWithImpl<$Res, RecordMeta>;
  @useResult
  $Res call({int cIndex, int pIndex});
}

/// @nodoc
class _$RecordMetaCopyWithImpl<$Res, $Val extends RecordMeta>
    implements $RecordMetaCopyWith<$Res> {
  _$RecordMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cIndex = null,
    Object? pIndex = null,
  }) {
    return _then(_value.copyWith(
      cIndex: null == cIndex
          ? _value.cIndex
          : cIndex // ignore: cast_nullable_to_non_nullable
              as int,
      pIndex: null == pIndex
          ? _value.pIndex
          : pIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecordMetaImplCopyWith<$Res>
    implements $RecordMetaCopyWith<$Res> {
  factory _$$RecordMetaImplCopyWith(
          _$RecordMetaImpl value, $Res Function(_$RecordMetaImpl) then) =
      __$$RecordMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int cIndex, int pIndex});
}

/// @nodoc
class __$$RecordMetaImplCopyWithImpl<$Res>
    extends _$RecordMetaCopyWithImpl<$Res, _$RecordMetaImpl>
    implements _$$RecordMetaImplCopyWith<$Res> {
  __$$RecordMetaImplCopyWithImpl(
      _$RecordMetaImpl _value, $Res Function(_$RecordMetaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cIndex = null,
    Object? pIndex = null,
  }) {
    return _then(_$RecordMetaImpl(
      cIndex: null == cIndex
          ? _value.cIndex
          : cIndex // ignore: cast_nullable_to_non_nullable
              as int,
      pIndex: null == pIndex
          ? _value.pIndex
          : pIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecordMetaImpl with DiagnosticableTreeMixin implements _RecordMeta {
  const _$RecordMetaImpl({this.cIndex = 0, this.pIndex = 0});

  factory _$RecordMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecordMetaImplFromJson(json);

  @override
  @JsonKey()
  final int cIndex;
  @override
  @JsonKey()
  final int pIndex;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RecordMeta(cIndex: $cIndex, pIndex: $pIndex)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RecordMeta'))
      ..add(DiagnosticsProperty('cIndex', cIndex))
      ..add(DiagnosticsProperty('pIndex', pIndex));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordMetaImpl &&
            (identical(other.cIndex, cIndex) || other.cIndex == cIndex) &&
            (identical(other.pIndex, pIndex) || other.pIndex == pIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cIndex, pIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordMetaImplCopyWith<_$RecordMetaImpl> get copyWith =>
      __$$RecordMetaImplCopyWithImpl<_$RecordMetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecordMetaImplToJson(
      this,
    );
  }
}

abstract class _RecordMeta implements RecordMeta {
  const factory _RecordMeta({final int cIndex, final int pIndex}) =
      _$RecordMetaImpl;

  factory _RecordMeta.fromJson(Map<String, dynamic> json) =
      _$RecordMetaImpl.fromJson;

  @override
  int get cIndex;
  @override
  int get pIndex;
  @override
  @JsonKey(ignore: true)
  _$$RecordMetaImplCopyWith<_$RecordMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
