import 'package:go_router/go_router.dart';
import 'package:wenku8x/service/navigation.dart';
import 'package:wenku8x/views/home/home_view.dart';
import 'package:wenku8x/views/login/login_view.dart';
import 'package:wenku8x/views/rank/rank_view.dart';
import 'package:wenku8x/views/search/search_view.dart';

import 'views/book_detail/book_detail_view.dart';

class AppPages {
  static GoRouter router = GoRouter(
    key: NavigationService.navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const Loginview(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchView(),
      ),
      GoRoute(
        path: '/rank/:type',
        builder: (context, state) {
          final type = state.params['type']!;
          return RankView(type);
        },
      ),
      GoRoute(
        path: '/book_detail/:aid',
        builder: (context, state) {
          final aid = state.params['aid']!;
          return BookDetailView(aid);
        },
      ),
    ],
  );
}
