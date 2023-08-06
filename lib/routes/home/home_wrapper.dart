import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/common/injectable/injectable_init.dart';
import 'package:test_app/features/home/presentation/bloc/home_bloc.dart';

class HomeWrapper extends StatelessWidget implements AutoRouteWrapper {
  const HomeWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeBloc>()),
      ],
      child: this,
    );
  }
}
