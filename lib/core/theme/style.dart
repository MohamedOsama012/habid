import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/theme/color.dart';

class TextAppStyle {
  static TextStyle mainTittel = TextStyle(
      fontSize: 45.sp,
      fontWeight: FontWeight.w900,
      color: AppColor.tittelText,
      fontFamily: "Nunito");
  static TextStyle subTittel = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.subText,
      fontFamily: "Nunito");
}
