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
    dispatch(
      bookmark: state.catalog,
      bottom: true,
      catalog: !state.catalog,
      typography: state.catalog,
      config: state.catalog,
      top: state.catalog,
    );
  }

  void toggleTypography() {
    state = state.copyWith(typography: !state.typography);
  }

  void toggleBookmark() {
    // state = state.copyWith(bookmark: !state.bookmark);
    dispatch(
      bookmark: !state.bookmark,
      bottom: true,
      catalog: state.bookmark,
      typography: state.bookmark,
      config: state.bookmark,
      top: state.bookmark,
    );
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
    bool? catalog,
    bool? bookmark,
    bool? typography,
    bool? config,
    bool? top,
    bool? bottom,
  }) {
    state = state.copyWith(
      catalog: catalog ?? state.catalog,
      bookmark: bookmark ?? state.bookmark,
      typography: typography ?? state.typography,
      config: config ?? state.config,
      top: top ?? state.top,
      bottom: bottom ?? state.bottom,
    );
  }
}
