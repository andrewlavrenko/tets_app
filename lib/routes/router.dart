import 'package:auto_route/annotations.dart';
import 'package:test_app/features/auth/presentation/auth_page.dart';
import 'package:test_app/features/home/presentation/home_page.dart';
import 'package:test_app/routes/home/home_guard.dart';
import 'package:test_app/routes/home/home_wrapper.dart';

@CupertinoAutoRouter(
  routes: [
    AutoRoute(
      page: HomeWrapper,
      initial: true,
      children: [
        AutoRoute(
          initial: true,
          guards: [HomeGuard],
          page: HomePage,
        ),
        AutoRoute(page: AuthPage),
      ],
    ),
  ],
)

class $AppRouter {}