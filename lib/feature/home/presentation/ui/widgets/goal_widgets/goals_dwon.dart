// Goal name input widget
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_track/feature/home/data/model/habit_model.dart';
import 'package:habit_track/feature/home/presentation/cubit/goal_cubit/cubit/goal_cubit.dart';
import 'package:habit_track/feature/home/presentation/ui/widgets/alert_widget/compont_widget_fort_alert.dart';

class GoalNameInput extends StatelessWidget {
  final TextEditingController controller;

  const GoalNameInput({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextPartInAlert(
      habitNameController: controller,
      hintText: 'Goal Name',
    );
  }
}

class HabitDropdown extends StatelessWidget {
  final ValueNotifier<String?> selectedHabitName;
  final ValueNotifier<String?> selectedHabitId;

  const HabitDropdown({
    required this.selectedHabitName,
    required this.selectedHabitId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HabitModel>>(
      future: context.read<GoalCubit>().getAllHabitInSystem(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Text('Failed to load habits');
        } else if (snapshot.hasData && snapshot.data != null) {
          return ValueListenableBuilder<String?>(
            valueListenable: selectedHabitName,
            builder: (context, selectedName, _) {
              return DropdownButtonFormField<String>(
                value: selectedName,
                onChanged: (String? newValue) {
                  selectedHabitName.value = newValue;
                  final selectedHabit = snapshot.data!.firstWhere(
                    (habit) => habit.name == newValue,
                  );
                  selectedHabitId.value = selectedHabit.habitId;
                },
                items: snapshot.data!
                    .map<DropdownMenuItem<String>>((HabitModel habit) {
                  return DropdownMenuItem<String>(
                    value: habit.name,
                    child: Text(habit.name),
                  );
                }).toList(),
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
          );
        } else {
          return const Text('No habits available');
        }
      },
    );
  }
}
