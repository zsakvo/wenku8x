import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:wenku8x/app/ui/components/bottom_nav.dart';
import 'package:wenku8x/app/ui/components/keep_alive.dart';
import 'package:wenku8x/discover/ui/discover_screen.dart';
import 'package:wenku8x/preference/ui/preference_screen.dart';
import 'package:wenku8x/shelf/ui/shelf_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class CustomNavigationHelper {
  static final CustomNavigationHelper _instance =
      CustomNavigationHelper._internal();

  static CustomNavigationHelper get instance => _instance;
  factory CustomNavigationHelper() {
    return _instance;
  }

  CustomNavigationHelper._internal() {
    // Router initialization happens here.
  }
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: "/shelf",
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      restorationScopeId: "home",
      builder: (context, state, navigationShell) {
        return BottomNav(
          navigationShell,
          items: [
            BottomBarItem(svgPath: "assets/svg/ic_bottom_books", label: "书架"),
            BottomBarItem(
              svgPath: "assets/svg/ic_bottom_discover",
              label: "发现",
            ),
            BottomBarItem(svgPath: "assets/svg/ic_bottom_ext", label: "设置"),
          ],
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/shelf',
              builder: (context, state) =>
                  const KeepAlivePage(child: ShelfScreen()),
            ),
          ],
          restorationScopeId: 'shelf',
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/discover',
              builder: (context, state) => const DiscoverScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/preference',
              builder: (context, state) => const PreferenceScreen(),
            ),
          ],
        ),
      ],
    ),
    // GoRoute(
    //   path: "/search",
    //   builder: (context, state) {
    //     final keyword = state.extra as String?;
    //     return SearchScreen(keyword: keyword);
    //   },
    // ),
  ],
);
