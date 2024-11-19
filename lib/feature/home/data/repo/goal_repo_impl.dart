import 'package:habit_track/feature/home/data/data_source/goal_data_source/goal_data_source.dart';
import 'package:habit_track/feature/home/data/data_source/goal_data_source/goal_data_source_abstract.dart';
import 'package:habit_track/feature/home/data/model/habit_model.dart';
import 'package:habit_track/feature/home/domian/repo/goal_repo.dart';

class GoalRepoImpl extends GoalRepo {
  GoalDataSource goalDataSource;
  GoalRepoImpl({required this.goalDataSource});
  @override
  Future<bool> creeateGoal(
      {required String goalName,
      required int period,
      required String habitId}) async {
    return await goalDataSource.creeateGoal(
        goalName: goalName, period: period, habitId: habitId);
  }

  @override
  Future<bool> deleteGoal({required String habitId}) async {
    return await goalDataSource.deleteGoal(habitId: habitId);
  }

  @override
  updateGoal({required String habitId, required bool isCompleted}) async {
    return await goalDataSource.updateGoal(
        habitId: habitId, isCompleted: isCompleted);
  }

  @override
  Future<List<HabitModel>> getAllGoal() async {
    return await goalDataSource.getAllGoal();
  }
}
