import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/theme/screen_size.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/feature/Auth/ui/widget/custom_button.dart';

class DeletGoal extends StatelessWidget {
  const DeletGoal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/Vector.png",
              height: 100,
            ),
            Text(
              "Are you sure want to delete?",
              style: TextAppStyle.subMainTittel.copyWith(fontSize: 20.sp),
            ),
            AppScreenUtil.hight(12),
            CustomButton(
              buttonName: "Delete",
              onPressed: () {},
            ),
            AppScreenUtil.hight(18),
            TextButton(
              onPressed: () {
                // Handle delete logic
              },
              child: Center(
                child: Text(
                  "cancel",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
