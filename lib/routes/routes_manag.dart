import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_track/feature/Auth/presentation/ui/screen/forget_password.dart';
import 'package:habit_track/feature/Auth/presentation/ui/screen/login_screen.dart';
import 'package:habit_track/feature/Auth/presentation/ui/screen/register_screen.dart';
import 'package:habit_track/feature/Settings/presentation/screen/account.dart';
import 'package:habit_track/feature/Settings/presentation/screen/chang_password.dart';
import 'package:habit_track/feature/calender/presentation/screen/habit_detials_screen.dart';
import 'package:habit_track/feature/home/data/repo/goal_repo_impl.dart';
import 'package:habit_track/feature/home/data/repo/habit_repo_impl.dart';
import 'package:habit_track/feature/home/presentation/cubit/goal_cubit/cubit/goal_cubit.dart';
import 'package:habit_track/feature/home/presentation/cubit/habit_cubit/habit_cubit.dart';
import 'package:habit_track/feature/home/presentation/ui/views/navbar.dart';
import 'package:habit_track/feature/home/presentation/ui/views/notfication_screen.dart';
import 'package:habit_track/routes/routes_name.dart';
import 'package:habit_track/service/service_locator.dart';
import 'package:habit_track/splash_screen.dart';

abstract class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.initialRoute,
        builder: (context, state) => splashScreen(),
      ),
      GoRoute(
        path: Routes.homeScreen,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider<HabitOperationCubit>(
              create: (context) => HabitOperationCubit(
                habitRepoImpl: getIt.get<HabitRepoImpl>(),
              )..getAllHabit(),
            ),
            BlocProvider<GoalCubit>(
              create: (context) => GoalCubit(
                goalRepoImpl: getIt.get<GoalRepoImpl>(),
              )..getAllGoal(),
            ),
          ],
          child: const BottomNavBar(),
        ),
      ),
      GoRoute(
        path: Routes.registerScreen,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: Routes.loginScreen,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: Routes.forgetPasswordScreen,
        builder: (context, state) => const ForgetPassword(),
      ),
      GoRoute(
        path: Routes.notficationScreen,
        builder: (context, state) => const NotifcationScreen(),
      ),
      GoRoute(
        path: Routes.detialsHabitScreen,
        builder: (context, state) {
          DateTime date = state.extra as DateTime;
          return HabitDetailsPage(date: date);
        },
      ),
      GoRoute(
        path: Routes.updateAccountScreen,
        builder: (context, state) {
          return const AccountPage();
        },
      ),
      GoRoute(
        path: Routes.changPasswordScreen,
        builder: (context, state) {
          return ChangePasswordScreen();
        },
      ),
    ],
  );
}
