import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wenku8x/reader/models/menu_visible.dart';

part 'menu_visible.g.dart';

@riverpod
class Menu extends _$Menu {
  @override
  MenuVisible build() {
    return MenuVisible();
  }

  void toggleBottom() {
    state = state.copyWith(bottom: !state.bottom);
  }

  void toggleTop() {
    state = state.copyWith(top: !state.top);
  }

  void toggleCatalog() {
    state = state.copyWith(catalog: !state.catalog);
  }

  void toggleTypography() {
    state = state.copyWith(typography: !state.typography);
  }

  void toggleTheme() {
    state = state.copyWith(theme: !state.theme);
  }

  void toggleConfig() {
    state = state.copyWith(config: !state.config);
  }
}
