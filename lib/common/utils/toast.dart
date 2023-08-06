import 'package:flutter/material.dart';
import 'package:test_app/common/theme/app_colors.dart';

class Toast {
  static void show(BuildContext context, String title, ToastStatus status) {
    final scaffold = ScaffoldMessenger.of(context);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    scaffold.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        backgroundColor: status == ToastStatus.success ? Colors.green : Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Text(title),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'ОК',
          textColor: AppColors.white,
          onPressed: scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }
}

enum ToastStatus { success, error }
