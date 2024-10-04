import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/theme/color.dart';
import 'package:habit_track/feature/home/ui/widget/alert_widget/edit_alert.dart';
import 'package:habit_track/feature/home/ui/widget/to_do_widgets/check_box.dart';

class HabitContiner extends StatefulWidget {
  const HabitContiner({super.key, required this.isDone});
  final bool isDone;

  @override
  State<HabitContiner> createState() => _HabitContinerState();
}

class _HabitContinerState extends State<HabitContiner> {
  late bool isChecked;
  @override
  void initState() {
    isChecked = widget.isDone;
    super.initState();
  }

  void showEditHabitDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return EditHabitDialog(); // Use the new dialog widget
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Column(
        children: [
          Container(
            width: double.infinity, // Adjust as needed
            height: 50.h, // Adjust height
            decoration: BoxDecoration(
              color: isChecked
                  ? AppColor.backgroundHabitDon
                  : AppColor
                      .backGroundNotDoneHabit, // Toggle color based on state
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '5 Prayers',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: isChecked
                          ? AppColor.doneHabitTextColor
                          : Colors.black, // Green text color
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    children: [
                      CustomCheckbox(
                        isChecked: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value; // Update the state
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        color: Colors.grey,
                        onPressed: () {
                          showEditHabitDialog(context); // Show the dialog
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
