import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wenku8x/http/ajax.dart';
import 'package:wenku8x/service/navigation.dart';
import 'package:wenku8x/utils/log.dart';
import 'package:wenku8x/views/home/home_view.dart';
import 'package:wenku8x/views/login/login_view.dart';
import 'package:wenku8x/views/preference/preference_view.dart';
import 'package:wenku8x/views/rank/rank_view.dart';
import 'package:wenku8x/views/reader/reader_view.dart';
import 'package:wenku8x/views/search/search_view.dart';
import 'package:wenku8x/views/search_result/search_result_view.dart';

import 'views/book_detail/book_detail_view.dart';

class AppPages {
  static GoRouter router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeView(),
        redirect: (context, state) async {
          Directory appDocDir = await getApplicationDocumentsDirectory();
          final cookieJar = PersistCookieJar(storage: FileStorage(appDocDir.path));
          final cookies = await cookieJar.loadForRequest(Uri.parse(Ajax.BASEURL));
          if (cookies.isNotEmpty) {
            return "/";
          } else {
            return "/login";
          }
        },
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
        path: '/search_result/:keyword',
        builder: (context, state) {
          final keyword = state.params['keyword']!;
          return SearchResultView(keyword);
        },
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
      GoRoute(
        path: '/reader/:aid',
        builder: (context, state) {
          final aid = state.params['aid']!;
          return ReaderView(aid);
        },
      ),
      GoRoute(
        path: '/preference',
        builder: (context, state) => const PreferenceView(),
      ),
    ],
  );
}
