import 'package:flutter/material.dart';
import 'package:test_app/common/enums/weather_unit.dart';
import 'package:test_app/common/theme/app_colors.dart';
import 'package:test_app/common/utils/weather_image_by_status.dart';

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
