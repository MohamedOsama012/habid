import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:habit_track/feature/home/data/goal_firebase_operation.dart';
import 'package:habit_track/feature/home/data/home_firebase_operation.dart';
import 'package:habit_track/feature/home/data/model/habit_model.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  FirebaseHomeOperation firebaseOperation = FirebaseHomeOperation();
  GoalFirebaseOperation f = GoalFirebaseOperation();

  List<HabitModel> notToDohabitList = [];
  List<HabitModel> toDohabitList = [];
  List<Goal> goalList = [];

  double getPrecentage() {
    if (toDohabitList.isEmpty) {
      return 0;
    } else {
      double percentage = (toDohabitList.length - notToDohabitList.length) /
          toDohabitList.length;
      return double.parse(percentage.toStringAsFixed(2));
    }
  }

  creatHabit({
    required String name,
    required String period,
    required List<String> customDays,
  }) async {
    emit(CreateHabitLoodin());
    bool result = await firebaseOperation.createHabit(
        habitName: name, period: period, customDays: customDays);
    if (result) {
      emit(creatHabiSuccses());
      await getAllHabit();
    } else {
      emit(CreatHabiFail());
    }
  }

  getAllHabit() async {
    toDohabitList.clear();
    notToDohabitList.clear();

    try {
      List<HabitModel> result = await firebaseOperation.getAllHabits();
      toDohabitList.addAll(result);
      await getnotDoneHabit(result);
      await getAllGoal(result);
      log("Updated goalList: ${goalList.length}");
      log("name ${goalList[1].name}");
      emit(GetHabitSucsess(habitData: result));
    } on Exception catch (e) {
      emit(GetHabitFail(massage: e.toString()));
    }
  }

  creatGoal({
    required String name,
    required String period,
    required habitId,
  }) async {
    emit(CreatGoalLoading());
    bool result =
        await f.creeateGoal(goalName: name, period: period, habitId: habitId);
    if (result) {
      emit(CreatGoalSucsses());
      await getAllHabit();
    } else {
      emit(CreatGoalFail());
    }
  }

  getAllGoal(List<HabitModel> result) {
    goalList.clear();

    for (int i = 0; i < result.length; i++) {
      if (result[i].goal != null) {
        goalList.add(result[i].goal!);
      }
    }

    log("eeeeee");
    log(goalList.length.toString());
  }

  getnotDoneHabit(List<HabitModel> result) async {
    try {
      for (int i = 0; i < result.length; i++) {
        if (result[i].progress!.isNotEmpty) {
          if (!result[i].progress![0].completed) {
            notToDohabitList.add(result[i]);
          }
        }
      }
      log("rrrrrrrrrrrrrrrrr");
      log(notToDohabitList.length.toString());
    } on Exception catch (e) {
      emit(GetHabitFail(massage: e.toString()));
    }
  }

  updateDoneHabit({required String habitId, required bool isComplet}) async {
    emit(DoneHabitLooding());
    bool result = await firebaseOperation.markHabit(
        habitId: habitId, isComplet: isComplet);
    if (result) {
      emit(DoneHabitSuscsses());
      await getAllHabit();
    } else {
      emit(DoneHabitFail());
    }
  }

  deletHabit({required String habitId}) async {
    emit(DeleteHabitLooding());
    log(habitId);
    bool result = await firebaseOperation.deletHabit(habitId: habitId);
    if (result) {
      emit(DeleteHabitSuscsses(massage: 'Delete'));
      await getAllHabit();
    } else {
      emit(DeleteHabitFail());
    }
  }

  updateHabit(
      {required String habitId,
      required String habitName,
      required String period,
      required List<String> customDays}) async {
    emit(UpdateHabitLooding());
    log(habitId);
    bool result = await firebaseOperation.updateHabitDate(
        habitId: habitId,
        habitName: habitName,
        period: period,
        customDay: customDays);
    if (result) {
      emit(UpdateHabitSuscsses(massage: 'Update'));
      await getAllHabit();
    } else {
      emit(UpdateHabitFail());
    }
  }

  @override
  void onChange(Change<HomeState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
