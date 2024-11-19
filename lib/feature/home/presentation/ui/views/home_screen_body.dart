import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_track/core/theme/screen_size.dart';
import 'package:habit_track/feature/home/data/repo/habit_repo_impl.dart';
import 'package:habit_track/feature/home/presentation/cubit/habit_cubit/habit_cubit.dart';
import 'package:habit_track/feature/home/presentation/ui/views/home_listiner.dart';
import 'package:habit_track/feature/home/presentation/ui/widgets/alert_widget/add_habit_alert.dart';
import 'package:habit_track/feature/home/presentation/ui/widgets/card_progress.dart';
import 'package:habit_track/feature/home/presentation/ui/widgets/goal_widget.dart';
import 'package:habit_track/feature/home/presentation/ui/widgets/todo_widget.dart';
import 'package:habit_track/feature/home/presentation/ui/widgets/top_page.dart';
import 'package:habit_track/service/service_locator.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeListenerWidget(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const TopPge(),
              AppScreenUtil.hight(12),
              const ProgressCard(),
              const ToDoWidget(),
              const GoalWidgetWithListener()
            ],
          ),
        ),
        floatingActionButton: const AddHabitButton(),
      ),
    );
  }
}

class AddHabitButton extends StatelessWidget {
  const AddHabitButton({super.key});

  @override
  Widget build(BuildContext context) {
    // final habitOperationCubit = context.read<HabitOperationCubit>();

    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Color(0xFF008eba),
            Color(0xFF01b1d8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: FloatingActionButton(
        onPressed: () {
          _showAlertDialog(context);
        },
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: getIt.get<HabitOperationCubit>(),
          child: const CreateNewHabit(),
        );
      },
    );
  }
}
