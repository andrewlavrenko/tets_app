import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:test_app/common/enums/weather_unit.dart';
import 'package:test_app/common/theme/app_colors.dart';
import 'package:test_app/common/theme/app_fonts.dart';
import 'package:test_app/common/theme/assets.dart';
import 'package:test_app/common/utils/hourly_weather_image_by_status.dart';
import 'package:test_app/common/utils/humidity_description.dart';
import 'package:test_app/common/utils/is_today.dart';
import 'package:test_app/common/utils/weather_image_by_status.dart';
import 'package:test_app/common/utils/wind_direction.dart';
import 'package:test_app/common/widgets/custom_loader_overlay.dart';
import 'package:test_app/features/home/domain/models/weather.dart';
import 'package:test_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:intl/intl.dart';

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
          child: HomePageBody(),
        ),
      ),
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({Key? key}) : super(key: key);

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
            return SingleChildScrollView(
              child: Column(
                children: [
                  AddressWidget(address: state.weather.address),
                  WeatherImageWidget(status: state.weather.conditions.first.status),
                  TemperatureWidget(weather: state.weather),
                  HourlyWeathersListWidget(
                      hourlyWeathers: state.hourlyWeathers.where((element) => isToday(element.date)).toList()),
                  WindAndHumidityWidget(
                    speed: state.weather.wind?.speed,
                    deg: state.weather.wind?.deg,
                    humidity: state.weather.humidity,
                  ),
                ],
              ),
            );
          } else if (state is HomeError) {
            context.loaderOverlay.hide();
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  bloc.add(GetWeatherEvent());
                },
                child: const Text('Повторить'),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class HourlyWeathersListWidget extends StatelessWidget {
  final List<HourlyWeather> hourlyWeathers;
  const HourlyWeathersListWidget({
    Key? key,
    required this.hourlyWeathers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white.withOpacity(0.2),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Сегодня',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                    fontFamily: AppFontFamily.roboto,
                  ),
                ),
                Text(
                  DateFormat('dd MMMM').format(DateTime.now()),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                    fontFamily: AppFontFamily.roboto,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColors.white,
            height: 1,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            height: 138,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => HourlyWeatherWidget(weather: hourlyWeathers[index]),
              itemCount: hourlyWeathers.length,
            ),
          ),
        ],
      ),
    );
  }
}

class HourlyWeatherWidget extends StatelessWidget {
  final HourlyWeather weather;
  const HourlyWeatherWidget({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return weather.date != null && weather.temperature?.temp !=null && weather.conditions.first.status != null
        ? Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              children: [
                Text(
                  DateFormat('kk:mm').format(weather.date!),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                    fontFamily: AppFontFamily.roboto,
                  ),
                ),
                const SizedBox(height: 16),
                SvgPicture.asset(hourlyWeatherImageByStatus(weather.conditions.first.status, true)),
                const SizedBox(height: 16),
                Text(
                  '${weather.temperature?.temp?.round()}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                    fontFamily: AppFontFamily.roboto,
                  ),
                ),
              ],
            ),
        )
        : const SizedBox.shrink();
  }
}

class AddressWidget extends StatelessWidget {
  final String? address;
  const AddressWidget({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          SvgPicture.asset(AssetIcons.icPin),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              address ?? '',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
                fontFamily: AppFontFamily.roboto,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WindAndHumidityWidget extends StatelessWidget {
  final double? speed;
  final int? deg;
  final int? humidity;
  const WindAndHumidityWidget({
    Key? key,
    required this.speed,
    required this.deg,
    required this.humidity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white.withOpacity(0.2),
      ),
      child: Column(
        children: [
          WindAndHumidityItem(
            icon: AssetIcons.icWind,
            value: '${speed?.round() ?? 0} м/с',
            title: 'Ветер ${windDirection(deg ?? 0)}',
          ),
          const SizedBox(height: 16),
          WindAndHumidityItem(
            icon: AssetIcons.icHumidity,
            value: '${humidity ?? 0}%',
            title: humidityDescription(humidity ?? 0),
          ),
        ],
      ),
    );
  }
}

class WindAndHumidityItem extends StatelessWidget {
  final String icon;
  final String value;
  final String title;
  const WindAndHumidityItem({
    Key? key,
    required this.icon,
    required this.value,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.white.withOpacity(0.2),
            fontFamily: AppFontFamily.roboto,
          ),
        ),
        const Spacer(),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.white,
            fontFamily: AppFontFamily.roboto,
          ),
        ),
      ],
    );
  }
}

class WeatherImageWidget extends StatelessWidget {
  final WeatherStatus? status;
  const WeatherImageWidget({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            color: AppColors.purple,
            blurRadius: 100,
          ),
        ],
      ),
      child: Image.asset(weatherImageByStatus(status)),
    );
  }
}

class TemperatureWidget extends StatelessWidget {
  final Weather weather;
  const TemperatureWidget({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${weather.temperature?.temp?.round() ?? 0}º',
          style: const TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
            fontFamily: AppFontFamily.ubuntu,
          ),
        ),
        Text(
          weather.conditions.first.description ?? '',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: AppColors.white,
            fontFamily: AppFontFamily.roboto,
          ),
        ),
        Text(
          'Макс.: ${weather.temperature?.maxTemp?.round() ?? 0}º Мин: ${weather.temperature?.minTemp?.round() ?? 0}º',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: AppColors.white,
            fontFamily: AppFontFamily.roboto,
          ),
        ),
      ],
    );
  }
}
