import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:habit_track/feature/home/cubit/cubit/home_cubit.dart';
import 'package:habit_track/feature/home/data/goal_firebase_operation.dart';
import 'package:habit_track/feature/home/data/model/habit_model.dart';
import 'package:meta/meta.dart';

part 'goal_state.dart';

class GoalCubit extends Cubit<GoalState> {
  GoalCubit() : super(GoalInitial());
  GoalFirebaseOperation firebaseOperation = GoalFirebaseOperation();

  getAllHabitInSystem() async {
    try {
      List<HabitModel> result = await firebaseOperation.getAllHabitInSystem();

      emit(GetHabitForGoalSucsess(habitData: result));
    } on Exception catch (e) {
      emit(GetHabitForGoaFail());
    }
  }

  // creatGoal({
  //   required String name,
  //   required String period,
  //   required habitId,
  // }) async {
  //   emit(CreatGoalLoading());
  //   bool result = await firebaseOperation.creeateGoal(
  //       goalName: name, period: period, habitId: habitId);
  //   if (result) {
  //     emit(CreatGoalSucsses());
  //     await homeCubit.getAllHabit();
  //   } else {
  //     emit(CreatGoalFail());
  //   }
  // }

  @override
  void onChange(Change<GoalState> change) {
    // TODO: implement onChange
    log("==============");
    log(change.toString());
    super.onChange(change);
  }
}
