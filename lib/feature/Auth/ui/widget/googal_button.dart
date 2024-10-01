import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/theme/color.dart';

class GoogalButton extends StatelessWidget {
  const GoogalButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
          border: Border.all(
            color: AppColor.borderColor,
            width: 1.0,
          ),
        ),
        child: Center(child: Image.asset("assets/images/Group.png")),
      ),
    );
  }
}
