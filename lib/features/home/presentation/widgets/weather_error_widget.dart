import 'package:flutter/material.dart';
import 'package:test_app/common/theme/app_colors.dart';
import 'package:test_app/common/theme/app_fonts.dart';

class WeatherErrorWidget extends StatelessWidget {
  final String message;
  final void Function()? onPressed;
  const WeatherErrorWidget({
    Key? key,
    required this.message,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
              fontFamily: AppFontFamily.roboto,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }
}
