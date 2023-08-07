import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_app/common/theme/app_colors.dart';
import 'package:test_app/common/theme/app_fonts.dart';
import 'package:test_app/common/utils/hourly_weather_image_by_status.dart';
import 'package:test_app/features/home/domain/models/weather.dart';
import 'package:intl/intl.dart';

class HourlyWeatherWidget extends StatelessWidget {
  final HourlyWeather weather;
  const HourlyWeatherWidget({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return weather.date != null && weather.temperature?.temp != null && weather.conditions.first.status != null
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
