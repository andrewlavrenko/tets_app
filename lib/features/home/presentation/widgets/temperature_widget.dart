import 'package:flutter/material.dart';
import 'package:test_app/common/theme/app_colors.dart';
import 'package:test_app/common/theme/app_fonts.dart';
import 'package:test_app/features/home/domain/models/weather.dart';

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
          '${weather.temperature?.temp ?? 0}º',
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
          'Макс.: ${weather.temperature?.maxTemp ?? 0}º Мин: ${weather.temperature?.minTemp ?? 0}º',
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
