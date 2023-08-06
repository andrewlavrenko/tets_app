import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:test_app/common/theme/app_colors.dart';

class CustomLoaderOverlay extends StatelessWidget {
  final Widget child;
  const CustomLoaderOverlay({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      disableBackButton: true,
      overlayColor: AppColors.white.withOpacity(0.25),
      overlayWidget: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const CircularProgressIndicator(
            strokeWidth: 3,
            color: AppColors.blue,
          ),
        ),
      ),
      child: child,
    );
  }
}
