import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:test_app/common/theme/app_colors.dart';
import 'package:test_app/common/utils/is_today.dart';
import 'package:test_app/common/widgets/custom_loader_overlay.dart';
import 'package:test_app/features/home/domain/models/weather.dart';
import 'package:test_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:test_app/features/home/presentation/widgets/address_widget.dart';
import 'package:test_app/features/home/presentation/widgets/weather_error_widget.dart';
import 'package:test_app/features/home/presentation/widgets/hourly_weathers_list_widget.dart';
import 'package:test_app/features/home/presentation/widgets/temperature_widget.dart';
import 'package:test_app/features/home/presentation/widgets/weather_image_widget.dart';
import 'package:test_app/features/home/presentation/widgets/wind_and_humidity_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.blue,
              AppColors.black,
            ],
          ),
        ),
        child: const SafeArea(
          child: _HomePageBody(),
        ),
      ),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    return CustomLoaderOverlay(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            bloc.add(GetWeatherEvent());
          } else if (state is HomeLoading) {
            context.loaderOverlay.show();
          } else if (state is HomeLoaded) {
            context.loaderOverlay.hide();
            return _LoadedHomePageBody(
              weather: state.weather,
              hourlyWeathers: state.hourlyWeathers.where((element) => isToday(element.date)).toList(),
            );
          } else if (state is HomeError) {
            context.loaderOverlay.hide();
            return WeatherErrorWidget(
              message: state.message,
              onPressed: () {
                bloc.add(GetWeatherEvent());
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _LoadedHomePageBody extends StatelessWidget {
  final Weather weather;
  final List<HourlyWeather> hourlyWeathers;
  const _LoadedHomePageBody({
    Key? key,
    required this.weather,
    required this.hourlyWeathers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AddressWidget(address: weather.address),
          WeatherImageWidget(status: weather.conditions.first.status),
          TemperatureWidget(weather: weather),
          HourlyWeathersListWidget(
            hourlyWeathers: hourlyWeathers
                .where(
                  (element) => isToday(element.date),
                )
                .toList(),
          ),
          WindAndHumidityWidget(
            speed: weather.wind?.speed,
            deg: weather.wind?.deg,
            humidity: weather.humidity,
          ),
        ],
      ),
    );
  }
}
