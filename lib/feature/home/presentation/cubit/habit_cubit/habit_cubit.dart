import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:habit_track/feature/home/data/model/habit_model.dart';
import 'package:habit_track/feature/home/data/repo/habit_repo_impl.dart';
import 'package:habit_track/service/const_varible.dart';
import 'package:habit_track/service/notfication_helper.dart';

part 'habit_state.dart';

class HabitOperationCubit extends Cubit<HomeState> {
  HabitOperationCubit({required this.habitRepoImpl}) : super(HomeInitial());

  HabitRepoImpl habitRepoImpl;

  List<HabitModel> notToDohabitList = [];
  List<HabitModel> toDohabitList = [];

  double getPrecentage() {
    if (toDohabitList.isEmpty) {
      return 0;
    } else {
      double percentage = (toDohabitList.length - notToDohabitList.length) /
          toDohabitList.length;
      return double.parse(percentage.toStringAsFixed(2));
    }
  }

  bool isDayFinished() {
    DateTime now = DateTime.now();
    DateTime midnight = DateTime(
        now.year, now.month, now.day, 23, 59, 59); // End of the day (midnight)
    return now.isAfter(midnight);
  }

  handelNotfication() {
    if (isNotificationEnabled!) {
      if (notToDohabitList.isEmpty && toDohabitList.isNotEmpty) {
        NotificationService.sendNotification(token!, "Congrats!",
            "🎉 You finished 100% of your habit for today! 🎯 ");
      } else if (isDayFinished() && notToDohabitList.isNotEmpty) {
        NotificationService.sendNotification(
          token!,
          "Reminder!",
          "😕 You did not finish all your habits today. You completed ${getPrecentage() * 100}% of your habits. Keep going! 💪 ",
        );
      }
    }
  }

//todo create habit

  creatHabit({
    required String name,
    required String period,
    required List<String> customDays,
  }) async {
    emit(CreateHabitLoodin());
    bool result = await habitRepoImpl.createHabit(
        habitName: name, period: period, customDays: customDays);
    if (result) {
      emit(creatHabiSuccses());
      await getAllHabit();
    } else {
      emit(CreatHabiFail());
    }
  }

  getAllHabit() async {
    try {
      List<HabitModel> result = await habitRepoImpl.getAllHabits();
      toDohabitList = result;
      await getUncompletHabit(result);
      handelNotfication();

      emit(GetHabitSucsess());
    } on Exception catch (e) {
      emit(GetHabitFail(massage: e.toString()));
    }
  }

  getUncompletHabit(List<HabitModel> result) async {
    List<HabitModel> not = [];

    try {
      for (int i = 0; i < result.length; i++) {
        if (result[i].progress!.isNotEmpty) {
          if (!result[i].progress![0].completed) {
            not.add(result[i]);
          }
        }
      }
      notToDohabitList = not;
    } on Exception catch (e) {
      emit(GetHabitFail(massage: e.toString()));
    }
  }

  updateDoneHabit(
      {required String habitId,
      required bool isComplet,
      required int index}) async {
    emit(DoneHabitLooding());
    bool result =
        await habitRepoImpl.markHabit(habitId: habitId, isComplet: isComplet);
    if (result) {
      emit(DoneHabitSuscsses(index: index, isMark: isComplet));

      await getAllHabit();
    } else {
      emit(DoneHabitFail());
    }
  }

  deletHabit({required String habitId}) async {
    emit(DeleteHabitLooding());
    bool result = await habitRepoImpl.deletHabit(habitId: habitId);
    if (result) {
      emit(DeleteHabitSuscsses(massage: 'Delete'));
      await getAllHabit();
    } else {
      emit(DeleteHabitFail());
    }
  }

  updateHabitData(
      {required String habitId,
      required String habitName,
      required String period,
      required List<String> customDays}) async {
    emit(UpdateHabitLooding());
    bool result = await habitRepoImpl.updateHabitDate(
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
    super.onChange(change);
  }
}
