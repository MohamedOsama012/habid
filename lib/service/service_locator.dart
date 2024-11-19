import 'package:get_it/get_it.dart';
import 'package:habit_track/feature/Auth/data/data_source/auth_data_source.dart';
import 'package:habit_track/feature/Auth/data/repo/auth_repo_impl.dart';
import 'package:habit_track/feature/Auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:habit_track/feature/calender/data/data_source/calender_data_source.dart';
import 'package:habit_track/feature/calender/data/repo/calnder_repo_impl.dart';
import 'package:habit_track/feature/home/data/data_source/goal_data_source/goal_data_source.dart';
import 'package:habit_track/feature/home/data/data_source/habit_data_source/habit_data_source.dart';
import 'package:habit_track/feature/home/data/repo/goal_repo_impl.dart';
import 'package:habit_track/feature/home/data/repo/habit_repo_impl.dart';
import 'package:habit_track/feature/home/presentation/cubit/habit_cubit/habit_cubit.dart';
import 'package:habit_track/service/firebase_service.dart';

final getIt = GetIt.instance;

void appIngection() {
  getIt.registerSingleton<HabitRepoImpl>(
    HabitRepoImpl(
      habitDataSource: HabitDataSourceImpl(
        firebaseService: FirebaseService(),
        goalRepoImpl: GoalRepoImpl(
          goalDataSource: GoalDataSourceImpl(
            firebaseService: FirebaseService(),
          ),
        ),
      ),
    ),
  );
  getIt.registerSingleton<GoalRepoImpl>(
    GoalRepoImpl(
      goalDataSource: GoalDataSourceImpl(
        firebaseService: FirebaseService(),
      ),
    ),
  );
  getIt.registerSingleton<CalenderRepoImpl>(
    CalenderRepoImpl(
      calenderDataSource:
          CalenderDataSourceImpl(firebaseService: FirebaseService()),
    ),
  );
  getIt.registerSingleton<HabitOperationCubit>(
      HabitOperationCubit(habitRepoImpl: getIt.get<HabitRepoImpl>()));
}
