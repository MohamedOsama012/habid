import 'package:flutter/material.dart';
import 'package:habit_track/feature/calender/presentation/cubit/cubit/calender_cubit.dart';

class SummaryDaySection extends StatelessWidget {
  final getHabitForSpacficDateSuccses state;

  const SummaryDaySection({required this.state});

  @override
  Widget build(BuildContext context) {
    double progress = (state.dataOfHabit.allHabit.length -
            state.dataOfHabit.notDoneHabit.length) /
        state.dataOfHabit.allHabit.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Summary Day',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 12,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              Text(
                '${(progress * 100).toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 20),
            const SizedBox(width: 5),
            Text(
              '${state.dataOfHabit.allHabit.length - state.dataOfHabit.notDoneHabit.length} Habits goal has achieved',
              style: const TextStyle(
                color: Colors.green,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cancel, color: Colors.red, size: 20),
            const SizedBox(width: 5),
            Text(
              '${state.dataOfHabit.notDoneHabit.length} Habits goal hasn\'t achieved',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(color: Colors.black, thickness: 1),
      ],
    );
  }
}
