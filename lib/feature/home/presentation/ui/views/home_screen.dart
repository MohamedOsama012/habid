import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_track/feature/home/data/repo/goal_repo_impl.dart';
import 'package:habit_track/feature/home/data/repo/habit_repo_impl.dart';
import 'package:habit_track/feature/home/presentation/cubit/goal_cubit/cubit/goal_cubit.dart';
import 'package:habit_track/feature/home/presentation/cubit/habit_cubit/habit_cubit.dart';
import 'package:habit_track/service/service_locator.dart';

import 'home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreenBody();
  }
}
