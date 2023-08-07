import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_app/common/theme/app_colors.dart';
import 'package:test_app/common/theme/app_fonts.dart';

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
