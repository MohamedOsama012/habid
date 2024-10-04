import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      width: double.infinity,
      height: 155.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF009bc5), // Right color #009BC5
            Color(0xFF009bc5),
            Color(0xFF0187b4), // Left color #0187B4
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFd9ecf2), // Shadow color #D9ECF2
            blurRadius: 10,
            offset: Offset(0, 8), // Horizontal and vertical offset
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Day',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularPercentIndicator(
                radius: 58.0.r,
                lineWidth: 13.0,
                animation: true,
                percent: 0.7,
                center: Text(
                  "70.0%",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21.sp,
                      color: Colors.white),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: const Color(0xFFf3fafc),
                progressColor: const Color(0xFF53e1f2),
              ),
              Text(
                "7 of 10 habits \ncompleted today !",
                style: TextAppStyle.subMainTittel
                    .copyWith(color: Colors.white, fontSize: 22.sp),
              )
            ],
          )
        ],
      ),
    );
  }
}
