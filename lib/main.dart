import 'package:flutter/material.dart';
import 'package:habit_track/core/global/global_function/init_fun.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:habit_track/habit_app.dart';
import 'package:habit_track/service/bloc_observer.dart';

import 'package:loader_overlay/loader_overlay.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlobalLoaderOverlay(child: HabitApp());
  }
}
