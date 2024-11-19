import 'package:habit_track/feature/home/data/model/habit_model.dart';

abstract class GoalDataSource {
  Future<bool> creeateGoal({
    required String goalName,
    required int period,
    required String habitId,
  });
  Future<bool> deleteGoal({
    required String habitId,
  });
  updateGoal({
    required String habitId,
    required bool isCompleted,
  });

  Future<List<HabitModel>> getAllGoal();
}
