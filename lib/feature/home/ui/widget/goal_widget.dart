import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/feature/home/cubit/cubit/home_cubit.dart';
import 'package:habit_track/feature/home/ui/widget/alert_widget/add_habit_alert.dart';
import 'package:habit_track/feature/home/ui/widget/alert_widget/create_goal_alert.dart';
import 'package:habit_track/feature/home/ui/widget/goal_widgets/goal_continer.dart';
import 'package:popover/popover.dart';

class GoalWidget extends StatelessWidget {
  const GoalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    log("enter ti goal widget");
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 18),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(57, 158, 158, 158), // Shadow color
              blurRadius: 10,
              offset: Offset(0, 8), // Horizontal and vertical offset
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              //!1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Goal',
                    style: TextAppStyle.mainTittel.copyWith(fontSize: 36.sp),
                  ),
                  IconButton(
                    onPressed: () {
                      // Show the alert dialog here
                      _showAddGoalDialog(context);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              //!2
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return cubit.goalList.isEmpty
                      ? Text("not goal Yet")
                      : ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GoalContaner(
                              dateGoal: cubit.goalList[index],
                              habitName: cubit.toDohabitList[index].name,
                            );
                          },
                          itemCount: cubit.goalList.length,
                        );
                },
              ),
              //!3
              TextButton(
                onPressed: () {},
                child: Text(
                  'show more',
                  style: TextAppStyle.subTittel,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Method to show the alert dialog
  void _showAddGoalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CreateNewGoal();
      },
    );
  }
}
