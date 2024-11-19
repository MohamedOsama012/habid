import 'package:bloc/bloc.dart';
import 'package:habit_track/feature/home/data/model/goal_model.dart';
import 'package:habit_track/feature/home/data/model/habit_model.dart';
import 'package:habit_track/feature/home/data/repo/goal_repo_impl.dart';
import 'package:meta/meta.dart';

part 'goal_state.dart';

class GoalCubit extends Cubit<GoalState> {
  GoalCubit({required this.goalRepoImpl}) : super(GoalInitial());
  List<Goal> goalList = [];
  GoalRepoImpl goalRepoImpl;

  Future<List<HabitModel>> getAllHabitInSystem() async {
    List<HabitModel> habitforgoal = [];
    try {
      List<HabitModel> result = await goalRepoImpl.getAllGoal();
      for (int i = 0; i < result.length; i++) {
        if (result[i].goal == null) {
          habitforgoal.add(result[i]);
        }
      }
      return habitforgoal;
    } on Exception catch (e) {
      return [];
    }
  }

  creatGoal({
    required String name,
    required int period,
    required habitId,
  }) async {
    emit(CreatGoalLoading());
    bool result = await goalRepoImpl.creeateGoal(
        goalName: name, period: period, habitId: habitId);
    if (result) {
      emit(CreatGoalSucsses());
      await getAllGoal();
    } else {
      emit(CreatGoalFail());
    }
  }

  deleteGoal({required String habitId}) async {
    emit(DeleteGoalLoad());
    bool result = await goalRepoImpl.deleteGoal(habitId: habitId);
    if (result) {
      emit(DeleteGoalSuccsess());
      await getAllGoal();
    } else {
      emit(DeleteGoalFail());
    }
  }

  getAllGoal() async {
    goalList.clear();
    List<HabitModel> result = await goalRepoImpl.getAllGoal();

    for (int i = 0; i < result.length; i++) {
      if (result[i].goal != null) {
        goalList.add(result[i].goal!);
      }
    }
    emit(GetAllGoalSuccsess());
  }

  @override
  void onChange(Change<GoalState> change) {
    super.onChange(change);
  }
}
