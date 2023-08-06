import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/common/injectable/injectable_init.dart';
import 'package:test_app/routes/home/home_guard.dart';
import 'package:test_app/routes/router.gr.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

final AppRouter _appRouter = AppRouter(homeGuard: HomeGuard());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return MaterialApp.router(
      title: 'Test App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
