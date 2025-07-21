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
    state = state.copyWith(catalog: !state.catalog, top: state.catalog);
  }

  void toggleTypography() {
    state = state.copyWith(typography: !state.typography);
  }

  void toggleBookmark() {
    state = state.copyWith(bookmark: !state.bookmark);
  }

  void toggleConfig() {
    state = state.copyWith(config: !state.config);
  }

  void reset() {
    state = MenuVisible();
  }

  void toggleParent() {
    state = state.copyWith(bottom: !state.bottom, top: !state.top);
  }

  void dispatch({
    bool? menuCatalogVisible,
    bool? menuBookmarkVisible,
    bool? menuTextVisible,
    bool? menuConfigVisible,
    bool? menuTopVisible,
    bool? menuBottomVisible,
  }) {
    state = state.copyWith(
      catalog: menuCatalogVisible ?? state.catalog,
      bookmark: menuBookmarkVisible ?? state.bookmark,
      typography: menuTextVisible ?? state.typography,
      config: menuConfigVisible ?? state.config,
      top: menuTopVisible ?? state.top,
      bottom: menuBottomVisible ?? state.bottom,
    );
  }
}
