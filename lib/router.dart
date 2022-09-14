import 'package:go_router/go_router.dart';
import 'package:wenku8x/views/home/home_view.dart';
import 'package:wenku8x/views/login/login_view.dart';

class AppPages {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const Loginview(),
      ),
    ],
  );
}
