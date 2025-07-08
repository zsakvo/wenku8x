import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_visible.g.dart';
part 'menu_visible.freezed.dart';

@freezed
abstract class MenuVisible with _$MenuVisible {
  const factory MenuVisible({
    @Default(false) bool bottom,
    @Default(false) bool top,
    @Default(false) bool catalog,
    @Default(false) bool typography,
    @Default(false) bool theme,
    @Default(false) bool config,
  }) = _MenuVisible;

  const MenuVisible._();

  factory MenuVisible.fromJson(Map<String, dynamic> json) =>
      _$MenuVisibleFromJson(json);

  bool get all => bottom || top || catalog || typography || theme || config;

  bool get sub => catalog || typography || theme || config;

  bool get parent => bottom || top;
}
