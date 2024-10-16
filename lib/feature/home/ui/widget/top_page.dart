import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/theme/color.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/service/const_varible.dart';
import 'package:intl/intl.dart'; // Import intl for date formatting

class TopPge extends StatelessWidget {
  // Add userName as a required parameter
  const TopPge({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current date and format it
    String formattedDate =
        DateFormat('EEE, d MMM. yyyy').format(DateTime.now());

    return Padding(
      padding: EdgeInsets.only(top: 15.h, right: 20.w, left: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dynamic date
              Text(
                formattedDate,
                style: TextAppStyle.subTittel.copyWith(
                    color: AppColor.dateColerHomePage,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp),
              ),
              // Greeting text with userName
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Hello, ",
                      style: TextAppStyle.subMainTittel.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 30.sp),
                    ),
                    TextSpan(
                      text: userName,
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
                  ],
                ),
              ),
            ],
          ),
          // Notification icon button
          IconButton(
            onPressed: () {
              // Add your notification action here
              print('Notification button pressed');
            },
            icon: const Icon(
              Icons.notifications,
              size: 32,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
