import 'package:flutter/material.dart';
import 'package:test_app/common/theme/app_colors.dart';
import 'package:test_app/common/theme/assets.dart';
import 'package:test_app/common/utils/humidity_description.dart';
import 'package:test_app/common/utils/wind_direction.dart';
import 'package:test_app/features/home/presentation/widgets/wind_and_humidity_item.dart';

class WindAndHumidityWidget extends StatelessWidget {
  final int? speed;
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
            value: '${speed ?? 0} м/с',
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
