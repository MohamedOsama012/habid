import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/feature/Auth/cubit/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_track/feature/home/cubit/cubit/home_cubit.dart';
import 'package:habit_track/feature/home/cubit/goal_cubit/cubit/goal_cubit.dart';
import 'package:habit_track/feature/home/data/home_firebase_operation.dart';

import 'package:habit_track/feature/home/ui/screen/navbar.dart';
import 'package:habit_track/firebase_options.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<HomeCubit>(
              create: (context) => HomeCubit()..getAllHabit(),
            ),
            BlocProvider<GoalCubit>(
              create: (context) => GoalCubit(),
            ),
            BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(), // Add your AuthCubit logic here
            ),
          ],
          child: MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white.withOpacity(.988),
            ),
            home: BottomNavBar(),
            // const RegisterScreen(),
          ),
        ),
      ),
    );
  }
}
/**
 *! login page
 *! forget password
 * !sure from controllar and validate
 *! do cubit
 *! do integrat with firebase
 *! show state in ui
 */
/**
 * !ui for home
 */
/**
 * todo shimmwer 
 *! todo empty list in home do not found  
 *
 * todo do validate in alert add or update
 * todo understand the custom period
 */
/**
 * do goal  
 * tine code 
 * clean code     
 * do notfication   
 * do shard pref    
 * do send forget password    
 * 
 do here multy bloc provider**/