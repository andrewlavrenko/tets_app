import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_app/common/theme/app_colors.dart';
import 'package:test_app/common/theme/app_fonts.dart';
import 'package:test_app/common/theme/assets.dart';

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
