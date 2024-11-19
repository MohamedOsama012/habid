import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_track/feature/timer/task.dart';
import 'package:habit_track/service/bloc_observer.dart';
import 'package:habit_track/service/cash_helper.dart';
import 'package:habit_track/service/firebase_options.dart';
import 'package:habit_track/service/notfication_helper.dart';
import 'package:habit_track/service/service_locator.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> initializeApp() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await CashNetwork.cashInitialization();
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox('taskBox');

  await NotificationService.initFirebaseMessaging();

  appIngection();
}
