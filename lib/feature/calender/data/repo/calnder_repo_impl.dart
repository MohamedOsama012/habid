import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:habit_track/feature/calender/data/data_source/calender_data_source.dart';
import 'package:habit_track/feature/calender/data/model/dialy_habit_summary_model.dart';
import 'package:habit_track/feature/calender/domian/calender_repo.dart';
import 'package:habit_track/feature/home/data/model/habit_model.dart';

class CalenderRepoImpl implements CalenderRepo {
  CalenderDataSource calenderDataSource;
  CalenderRepoImpl({required this.calenderDataSource});

  @override
  Future<Map<DateTime, List<Event>>> lodaAllDateHabit() async {
    return await calenderDataSource.lodaAllDateHabit();
  }

  @override
  Future<HabitModel?> gettHabit({required String habitId}) async {
    return await calenderDataSource.gettHabit(habitId: habitId);
  }

  @override
  Future<HabitDialySummaryModel> getHabitForSpacficDate(
      {required String date}) {
    return calenderDataSource.getHabitForSpacficDate(date: date);
  }
}
