import 'package:go_router/go_router.dart';
import 'package:behnam_portfolio/core/routing/app_routes.dart';
import 'package:behnam_portfolio/features/home/presentation/pages/home_page.dart';
import 'package:behnam_portfolio/features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final validRoutes = [
        AppRoutes.splash,
        AppRoutes.home,
      ];

      if (!validRoutes.contains(state.matchedLocation)) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) {
          return const HomePage();
        },
      ),
    ],
  );
}
