import 'package:freezed_annotation/freezed_annotation.dart';

part 'preference.g.dart';
part 'preference.freezed.dart';

enum AppBrightness { system, light, dark }

enum StyleMode { preset, md3 }

enum AppLanguage { sc, tc }

@freezed
abstract class PreferenceModel with _$PreferenceModel {
  const factory PreferenceModel({
    @Default(AppBrightness.system) AppBrightness brightness,
    @Default(StyleMode.preset) StyleMode styleMode,
    @Default(AppLanguage.sc) AppLanguage language,
  }) = _PreferenceModel;

  factory PreferenceModel.fromJson(Map<String, dynamic> json) =>
      _$PreferenceModelFromJson(json);

  const PreferenceModel._();
}
