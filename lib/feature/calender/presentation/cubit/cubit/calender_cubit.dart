import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:habit_track/feature/calender/data/data_source/calender_data_source.dart';
import 'package:habit_track/feature/calender/data/firebase_operation_calender.dart';
import 'package:habit_track/feature/calender/data/model/dialy_habit_summary_model.dart';
import 'package:habit_track/feature/calender/data/repo/calnder_repo_impl.dart';
import 'package:habit_track/feature/home/data/model/habit_model.dart';
import 'package:meta/meta.dart';

part 'calender_state.dart';

class CalenderCubit extends Cubit<CalenderState> {
  CalenderCubit({required this.calenderRepoImpl}) : super(CalenderInitial());
  CalenderRepoImpl calenderRepoImpl;
  getDataOfHabet({required String date}) async {
    emit(getHabitForSpacficDateLoadin());
    try {
      HabitDialySummaryModel result =
          await calenderRepoImpl.getHabitForSpacficDate(date: date);
      emit(getHabitForSpacficDateSuccses(dataOfHabit: result));
    } on Exception catch (e) {
      emit(getHabitForSpacficDateFail(massage: e.toString()));
    }
  }

  getSingleHabit({required String habitId}) async {
    HabitModel? result = await calenderRepoImpl.gettHabit(habitId: habitId);
    return result!.name;
  }

  Future<Map<DateTime, List<Event>>> loadColorDate() async {
    return await calenderRepoImpl.lodaAllDateHabit();
  }

  @override
  void onChange(Change<CalenderState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
