import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habit_track/feature/home/data/data_source/habit_data_source/habit_data_source_abstract.dart';
import 'package:habit_track/feature/home/data/model/habit_model.dart';
import 'package:habit_track/feature/home/domian/repo/habit_repo.dart';

class HabitRepoImpl extends HabitRepository {
  HabitDataSource habitDataSource;
  HabitRepoImpl({required this.habitDataSource});
  @override
  Future<HabitModel> creatProgressHabit(QueryDocumentSnapshot<Object?> doc,
      String userId, String todayDate) async {
    return await habitDataSource.creatProgressHabit(doc, userId, todayDate);
  }

  @override
  Future<bool> createHabit(
      {required String habitName,
      required String period,
      required List<String> customDays}) {
    return habitDataSource.createHabit(
        habitName: habitName, period: period, customDays: customDays);
  }

  @override
  Future<bool> deletHabit({required String habitId}) {
    return habitDataSource.deletHabit(habitId: habitId);
  }

  @override
  Future<List<HabitModel>> getAllHabits() {
    return habitDataSource.getAllHabits();
  }

  @override
  Future<bool> markHabit({required String habitId, required bool isComplet}) {
    return habitDataSource.markHabit(habitId: habitId, isComplet: isComplet);
  }

  @override
  Future<bool> updateDailySummary(
      {required String habitId, required bool isComplet}) {
    return habitDataSource.updateDailySummary(
        habitId: habitId, isComplet: isComplet);
  }

  @override
  Future<bool> updateHabitDate(
      {required String habitId,
      required String habitName,
      required String period,
      required List<String> customDay}) {
    return habitDataSource.updateHabitDate(
        habitId: habitId,
        habitName: habitName,
        period: period,
        customDay: customDay);
  }
}
