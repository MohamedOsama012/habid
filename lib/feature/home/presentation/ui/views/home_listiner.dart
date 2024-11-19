import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_track/core/global/global_widget/app_snackbar.dart';
import 'package:habit_track/feature/home/presentation/cubit/goal_cubit/cubit/goal_cubit.dart';
import 'package:habit_track/feature/home/presentation/cubit/habit_cubit/habit_cubit.dart';

class HomeListenerWidget extends StatelessWidget {
  const HomeListenerWidget({super.key, required this.child});

  final Widget child;
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GoalCubit, GoalState>(
          listener: (context, state) {
            if (state is CreatGoalSucsses) {
              Navigator.pop(context);

              AppStuts.showToats("Create Goal Succsufly",
                  const Color.fromARGB(255, 12, 150, 17));
            }
            if (state is CreatGoalFail) {
              AppStuts.showToats("Tray agian", Colors.red);
            }
            if (state is DeleteGoalSuccsess) {
              Navigator.pop(context);

              AppStuts.showCustomSnackBar(
                  context, "Delete succsufly", Icons.check);
            }
            if (state is DeleteGoalFail) {
              Navigator.pop(context);

              AppStuts.showToats("Tray agian", Colors.red);
            }
          },
        ),
        BlocListener<HabitOperationCubit, HomeState>(
          listener: (context, state) {
            if (state is creatHabiSuccses) {
              Navigator.pop(context);

              AppStuts.showToats("Create Habit Succsufly",
                  const Color.fromARGB(255, 12, 150, 17));
            }
            if (state is CreatHabiFail) {
              Navigator.pop(context);

              AppStuts.showToats("Unsuccsufly create habit", Colors.red);
            }
            if (state is DoneHabitSuscsses) {
              state.isMark!
                  ? AppStuts.showToats(
                      " Mark Succsufly", const Color.fromARGB(255, 12, 150, 17))
                  : AppStuts.showToats(" UnMark Habit", Colors.black);
            }
            if (state is DeleteHabitSuscsses) {
              Navigator.pop(context);

              AppStuts.showCustomSnackBar(
                  context, "Delete succsufly", Icons.check);
            }
            if (state is UpdateHabitSuscsses) {
              Navigator.pop(context);

              AppStuts.showToats(
                  "Update Succsufly", const Color.fromARGB(255, 12, 150, 17));
            }
          },
        ),
      ],
      child: child,
    );
  }
}
