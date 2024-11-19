import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_track/feature/calender/presentation/cubit/cubit/calender_cubit.dart';

class GoalsListSection extends StatelessWidget {
  final getHabitForSpacficDateSuccses state;

  const GoalsListSection({required this.state});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.dataOfHabit.allHabit.length,
        itemBuilder: (context, index) {
          final habitId = state.dataOfHabit.allHabit[index];

          return FutureBuilder<dynamic>(
            future:
                context.read<CalenderCubit>().getSingleHabit(habitId: habitId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const ListTile(
                  title: Text('Loading...'),
                  trailing: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const ListTile(
                  title: Text('Delete this habit'),
                  trailing: Icon(Icons.error, color: Colors.red),
                );
              } else if (snapshot.hasData) {
                String name = snapshot.data!;
                return ListTile(
                  title: Text(name),
                  trailing: Icon(
                    state.dataOfHabit.notDoneHabit.contains(habitId)
                        ? Icons.cancel
                        : Icons.check_circle,
                    color: state.dataOfHabit.notDoneHabit.contains(habitId)
                        ? Colors.red
                        : Colors.green,
                  ),
                );
              } else {
                return const ListTile(
                  title: Text('No habit data'),
                );
              }
            },
          );
        },
      ),
    );
  }
}
