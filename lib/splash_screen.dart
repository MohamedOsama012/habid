import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_track/feature/Auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:habit_track/feature/Auth/presentation/ui/screen/register_screen.dart';
import 'package:habit_track/feature/home/presentation/ui/views/navbar.dart';
import 'package:habit_track/routes/routes_name.dart';

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await BlocProvider.of<UserCubit>(context).getUserData();

        context.pushReplacement(Routes.homeScreen);
      } else {
        context.pushReplacement(Routes.registerScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/splash.jpg',
            fit: BoxFit.cover,
          ),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 140),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
