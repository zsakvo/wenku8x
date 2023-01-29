import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/modals/config.dart';

final _box = Hive.box<Config>("config");

class PreferenceNotifier extends StateNotifier<Config> {
  PreferenceNotifier()
      : super(_box.get("appConfig") ??
            const Config(
                dynamicColor: true,
                highRefreshRate: false,
                autoSign: false,
                traditionalChinese: false));

  toggleDynamicColor() {
    state = state.copyWith(dynamicColor: !state.dynamicColor!);
    saveConfig();
  }

  toggleHighRefreshRate() {
    state = state.copyWith(highRefreshRate: !state.highRefreshRate!);
    saveConfig();
  }

  toggleAutoSign() {
    state = state.copyWith(autoSign: !state.autoSign!);
    saveConfig();
  }

  toggleTraditionalChinese() {
    state = state.copyWith(traditionalChinese: !state.traditionalChinese!);
    saveConfig();
  }

  saveConfig() {
    _box.put("appConfig", state);
  }
}

final preferenceProvider =
    StateNotifierProvider<PreferenceNotifier, Config>((ref) {
  return PreferenceNotifier();
});
