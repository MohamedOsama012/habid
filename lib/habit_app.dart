import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/theme/color.dart';
import 'package:habit_track/feature/Auth/data/data_source/auth_data_source.dart';
import 'package:habit_track/feature/Auth/data/repo/auth_repo_impl.dart';
import 'package:habit_track/feature/Auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:habit_track/routes/routes_manag.dart';

class HabitApp extends StatefulWidget {
  const HabitApp({super.key});

  @override
  State<HabitApp> createState() => _HabitAppState();
}

class _HabitAppState extends State<HabitApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider(
        create: (context) => UserCubit(
          authRepoImpl: AuthRepoImpl(authDataSource: AuthDataSourceImpl()),
        ),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: AppColor.primeColor,
            ),
            scaffoldBackgroundColor: Colors.white.withOpacity(.988),
          ),
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
/**
 * main
* 
 */