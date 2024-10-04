import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/theme/color.dart';
import 'package:habit_track/core/theme/style.dart';

class TopPge extends StatelessWidget {
  const TopPge({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h, right: 20.w, left: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sun, 29 Sep. 2024",
                style: TextAppStyle.subTittel.copyWith(
                    color: AppColor.dateColerHomePage,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "Hallo, ",
                    style: TextAppStyle.subMainTittel.copyWith(
                        fontWeight: FontWeight.w600, fontSize: 30.sp)),
                TextSpan(
                  text: "Gasser",
                  style: TextAppStyle.subMainTittel.copyWith(
                    fontSize: 30.sp,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: [
                          Color(0xFF08D9D6), // #08D9D6
                          Color(0xFF0083B0), // #0083B0
                        ],
                      ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                  ),
                ),
              ]))
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              size: 32,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
