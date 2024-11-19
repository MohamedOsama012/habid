import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:habit_track/feature/calender/data/model/dialy_habit_summary_model.dart';
import 'package:habit_track/feature/home/data/model/habit_model.dart';

abstract class CalenderRepo {
  Future<Map<DateTime, List<Event>>> lodaAllDateHabit();
  Future<HabitDialySummaryModel> getHabitForSpacficDate({required String date});
  Future<HabitModel?> gettHabit({required String habitId});
}
