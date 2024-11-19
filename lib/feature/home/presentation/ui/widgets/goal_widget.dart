import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/feature/home/presentation/ui/widgets/alert_widget/create_goal_alert.dart';
import 'package:habit_track/feature/home/presentation/ui/widgets/goal_widgets/goal_continer.dart';
import 'package:habit_track/feature/home/presentation/cubit/goal_cubit/cubit/goal_cubit.dart';
import 'package:habit_track/feature/home/presentation/cubit/habit_cubit/habit_cubit.dart';
import 'package:habit_track/feature/home/presentation/ui/widgets/goal_widgets/goal_widget.dart';

class GoalWidgetWithListener extends StatelessWidget {
  const GoalWidgetWithListener({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<GoalCubit>(context);
    return BlocListener<HabitOperationCubit, HomeState>(
      listener: (context, state) {
        if (state is DoneHabitSuscsses || state is DeleteHabitSuscsses) {
          cubit.getAllGoal();
        }
      },
      child: const GoalWidget(),
    );
  }
}
