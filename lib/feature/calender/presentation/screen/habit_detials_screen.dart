import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_track/feature/calender/data/data_source/calender_data_source.dart';
import 'package:habit_track/feature/calender/data/repo/calnder_repo_impl.dart';
import 'package:habit_track/feature/calender/presentation/cubit/cubit/calender_cubit.dart';
import 'package:habit_track/feature/calender/presentation/screen/widgets/goal_list_widget.dart';
import 'package:habit_track/feature/calender/presentation/screen/widgets/progress_widget.dart';
import 'package:habit_track/feature/calender/presentation/screen/widgets/summary_day_widget.dart';
import 'package:habit_track/service/firebase_service.dart';
import 'package:habit_track/service/service_locator.dart';
import 'package:intl/intl.dart';

class HabitDetailsPage extends StatelessWidget {
  final DateTime date;

  HabitDetailsPage({required this.date});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CalenderCubit(calenderRepoImpl: getIt.get<CalenderRepoImpl>())
            ..getDataOfHabet(date: DateFormat('yyyy-MM-dd').format(date)),
      child: BlocBuilder<CalenderCubit, CalenderState>(
        builder: (context, state) {
          if (state is getHabitForSpacficDateLoadin) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is getHabitForSpacficDateSuccses) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'Progress',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ProgressReportSection(date: date),
                    const SizedBox(height: 30),
                    SummaryDaySection(state: state),
                    const SizedBox(height: 10),
                    GoalsListSection(state: state),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
