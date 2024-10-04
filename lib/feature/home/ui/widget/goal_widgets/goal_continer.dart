import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/theme/color.dart';
import 'package:habit_track/core/theme/screen_size.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/feature/Auth/ui/widget/custom_button.dart';
import 'package:habit_track/feature/home/ui/screen/home_screen.dart';
import 'package:habit_track/feature/home/ui/widget/alert_widget/delete_alert.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class GoalContaner extends StatelessWidget {
  const GoalContaner({super.key});
  void showEditHabitDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const DeletGoal(); // Use the new dialog widget
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColor.backGroundNotDoneHabit, // Toggle color based on state
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Finish 5 Prayers",
              style: TextAppStyle.subMainTittel.copyWith(fontSize: 22),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LinearPercentIndicator(
                    animation: true,
                    width: AppScreenUtil.getResponsiveWidth(context, .7),
                    lineHeight: 10,
                    percent: 0.8,
                    backgroundColor: AppColor.backGroundLinearProgress,
                    linearGradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppColor.checkBoxDoneHabitColor,
                        AppColor.secondCheckBoxDoneHabitColor,
                      ],
                    )),
                InkWell(
                  onTap: () {
                    showEditHabitDialog(context);
                  },
                  child: const Icon(
                    Icons.delete_sharp,
                    color: Color.fromARGB(170, 158, 158, 158),
                  ),
                )
              ],
            ),
            Text(
              "5 from 7 days target",
              style: TextAppStyle.subTittel.copyWith(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
