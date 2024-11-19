import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_track/feature/home/data/model/habit_model.dart';
import 'package:habit_track/feature/home/presentation/cubit/habit_cubit/habit_cubit.dart';
import 'package:habit_track/feature/home/presentation/ui/widgets/to_do_widgets/habit_continer.dart';

class NotToDoHabitsList extends StatelessWidget {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  NotToDoHabitsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HabitOperationCubit, HomeState>(
      listener: (context, state) {
        if (state is DoneHabitSuscsses) {
          final notToDoHabits =
              context.read<HabitOperationCubit>().notToDohabitList;
          if (notToDoHabits.isNotEmpty) {
            final index = state.index;
            final removedHabit = notToDoHabits.removeAt(index);
            listKey.currentState?.removeItem(
              index,
              (context, animation) =>
                  _buildRemovedItem(removedHabit, animation, index),
              duration: const Duration(milliseconds: 300),
            );
          }
        }
      },
      builder: (context, state) {
        final notToDoHabits =
            context.read<HabitOperationCubit>().notToDohabitList;
        return notToDoHabits.isEmpty
            ? const Center(
                child: Text("All habits completed!"),
              )
            : AnimatedList(
                key: listKey,
                initialItemCount: notToDoHabits.length,
                itemBuilder: (context, index, animation) {
                  return _buildAnimatedItem(
                      notToDoHabits[index], animation, index);
                },
              );
      },
    );
  }

  Widget _buildAnimatedItem(
      HabitModel habit, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: HabitContiner(habitDate: habit, index: index),
    );
  }

  Widget _buildRemovedItem(
      HabitModel habit, Animation<double> animation, int index) {
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        child: HabitContiner(habitDate: habit, index: index),
      ),
    );
  }
}
