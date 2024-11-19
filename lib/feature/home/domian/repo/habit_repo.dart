import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habit_track/feature/home/data/model/habit_model.dart';

abstract class HabitRepository {
  Future<bool> createHabit({
    required String habitName,
    required String period,
    required List<String> customDays,
  });

  Future<bool> markHabit({
    required String habitId,
    required bool isComplet,
  });

  Future<bool> updateDailySummary({
    required String habitId,
    required bool isComplet,
  });

  Future<List<HabitModel>> getAllHabits();

  Future<HabitModel> creatProgressHabit(
    QueryDocumentSnapshot doc,
    String userId,
    String todayDate,
  );

  Future<bool> deletHabit({required String habitId});

  Future<bool> updateHabitDate({
    required String habitId,
    required String habitName,
    required String period,
    required List<String> customDay,
  });
}
