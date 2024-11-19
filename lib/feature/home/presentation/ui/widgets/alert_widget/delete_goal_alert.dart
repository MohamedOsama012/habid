import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/theme/screen_size.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/feature/Auth/presentation/ui/widget/custom_button.dart';
import 'package:habit_track/feature/home/presentation/cubit/goal_cubit/cubit/goal_cubit.dart';

class DeletGoal extends StatelessWidget {
  const DeletGoal({super.key, required this.habitId});
  final String habitId;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
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
            BlocBuilder<GoalCubit, GoalState>(
              builder: (context, state) {
                return state is DeleteGoalLoad
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        buttonName: "Delete",
                        onPressed: () {
                          context
                              .read<GoalCubit>()
                              .deleteGoal(habitId: habitId);
                        },
                      );
              },
            ),
            AppScreenUtil.hight(18),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Center(
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
