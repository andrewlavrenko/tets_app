import 'package:flutter/material.dart';
import 'package:test_app/common/theme/app_colors.dart';
import 'package:test_app/common/theme/app_fonts.dart';
import 'package:test_app/features/home/domain/models/weather.dart';
import 'package:intl/intl.dart';
import 'package:test_app/features/home/presentation/widgets/hourly_weather_widget.dart';

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
