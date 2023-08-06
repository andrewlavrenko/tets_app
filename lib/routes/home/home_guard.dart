import 'package:auto_route/auto_route.dart';
import 'package:test_app/common/injectable/injectable_init.dart';
import 'package:test_app/features/auth/domain/repository.dart';
import 'package:test_app/routes/router.gr.dart';

class HomeGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isAuthorized = await getIt<AuthRepository>().getAuthState();
    if (isAuthorized) {
      resolver.next(true);
    } else {
      router.push(const AuthPageRoute());
    }
  }
}
