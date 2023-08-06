// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../features/auth/presentation/auth_page.dart' as _i3;
import '../features/home/presentation/home_page.dart' as _i2;
import 'home/home_guard.dart' as _i6;
import 'home/home_wrapper.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter({
    _i5.GlobalKey<_i5.NavigatorState>? navigatorKey,
    required this.homeGuard,
  }) : super(navigatorKey);

  final _i6.HomeGuard homeGuard;

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomeWrapperRoute.name: (routeData) {
      return _i4.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i4.WrappedRoute(child: const _i1.HomeWrapper()),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i4.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    AuthPageRoute.name: (routeData) {
      return _i4.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AuthPage(),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          HomeWrapperRoute.name,
          path: '/',
          children: [
            _i4.RouteConfig(
              HomePageRoute.name,
              path: '',
              parent: HomeWrapperRoute.name,
              guards: [homeGuard],
            ),
            _i4.RouteConfig(
              AuthPageRoute.name,
              path: 'auth-page',
              parent: HomeWrapperRoute.name,
            ),
          ],
        )
      ];
}

/// generated route for
/// [_i1.HomeWrapper]
class HomeWrapperRoute extends _i4.PageRouteInfo<void> {
  const HomeWrapperRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeWrapperRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomeWrapperRoute';
}

/// generated route for
/// [_i2.HomePage]
class HomePageRoute extends _i4.PageRouteInfo<void> {
  const HomePageRoute()
      : super(
          HomePageRoute.name,
          path: '',
        );

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i3.AuthPage]
class AuthPageRoute extends _i4.PageRouteInfo<void> {
  const AuthPageRoute()
      : super(
          AuthPageRoute.name,
          path: 'auth-page',
        );

  static const String name = 'AuthPageRoute';
}
