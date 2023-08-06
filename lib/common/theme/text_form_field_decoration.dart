import 'package:flutter/material.dart';
import 'package:test_app/common/theme/app_colors.dart';
import 'package:test_app/common/theme/app_fonts.dart';

class TFFDecoration {
  static const enabledBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.lightGrey,
    ),
  );
  static const focusedBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      width: 2,
      color: AppColors.blue,
    ),
  );
  static const floatingLabelStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
    fontFamily: AppFontFamily.roboto,
  );
  static const labelStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
    fontFamily: AppFontFamily.roboto,
  );
  static const textStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w400,
  color: AppColors.lightBlack,
  fontFamily: AppFontFamily.roboto,
  );
}
