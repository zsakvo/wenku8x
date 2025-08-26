import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_visible.g.dart';

int SHOW_BOTTOM_MENU = 1 << 1;
int SHOW_TOP_MENU = 1 << 2;
int SHOW_CATALOG_MENU = 1 << 3;
int SHOW_BOOKMARK_MENU = 1 << 4;
int SHOW_TYPOGRAPHY_MENU = 1 << 5;
int SHOW_CONFIG_MENU = 1 << 6;

@riverpod
class Menu extends _$Menu {
  @override
  int build() {
    return 0;
  }

  toggleSubMenu(int menu) {
    if (state & menu == 0) {
      state = 0 | SHOW_BOTTOM_MENU | menu;
    } else {
      disposeSubMenus();
    }
  }

  disposeSubMenus() {
    state = 0 | SHOW_BOTTOM_MENU | SHOW_TOP_MENU;
  }

  disposeAll() {
    state = 0;
  }

  toggleParent() {
    state ^= (SHOW_BOTTOM_MENU | SHOW_TOP_MENU);
  }
}

extension MenuStateExtension on int {
  bool get bottomVisible => this & SHOW_BOTTOM_MENU != 0;
  bool get topVisible => this & SHOW_TOP_MENU != 0;
  bool get catalogVisible => this & SHOW_CATALOG_MENU != 0;
  bool get typographyVisible => this & SHOW_TYPOGRAPHY_MENU != 0;
  bool get bookmarkVisible => this & SHOW_BOOKMARK_MENU != 0;
  bool get configVisible => this & SHOW_CONFIG_MENU != 0;
  bool get bottomAndTopVisible =>
      this & (SHOW_BOTTOM_MENU | SHOW_TOP_MENU) != 0;
  bool get subMenuVisible =>
      this &
          (SHOW_CATALOG_MENU |
              SHOW_BOOKMARK_MENU |
              SHOW_TYPOGRAPHY_MENU |
              SHOW_CONFIG_MENU) !=
      0;
}
