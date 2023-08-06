// ignore_for_file: literal_only_boolean_expressions

import 'package:auto_route/auto_route.dart';

class HomeGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (true) {
      resolver.next(true);
    } else {
      //router.push(AuthPageRoute());
    }
  }
}
