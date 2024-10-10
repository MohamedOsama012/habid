import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/feature/Auth/cubit/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:habit_track/feature/home/ui/screen/navbar.dart';
import 'package:habit_track/feature/Auth/ui/screen/register_screen.dart';
import 'package:habit_track/feature/Settings/screen/settting.dart';
import 'package:habit_track/firebase_options.dart';
import 'package:habit_track/splash_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'splash_screen.dart';

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
        child: BlocProvider(
          create: (context) => AuthCubit(),
          child: MaterialApp(
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white.withOpacity(.988),
              ),
              home: splashScreen()
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
 * ui for home
 */
