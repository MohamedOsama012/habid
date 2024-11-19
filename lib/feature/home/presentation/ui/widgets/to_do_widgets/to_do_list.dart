import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_track/core/global/global_widget/shimmer_widget.dart';
import 'package:habit_track/feature/home/presentation/cubit/habit_cubit/habit_cubit.dart';
import 'package:habit_track/feature/home/presentation/ui/widgets/to_do_widgets/habit_continer.dart';

class ToDoHabitsList extends StatelessWidget {
  final bool showAll;

  const ToDoHabitsList({super.key, required this.showAll});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitOperationCubit, HomeState>(
      builder: (context, state) {
        final habitData = context.read<HabitOperationCubit>().toDohabitList;
        if (state is HomeInitial) {
          return ListView.builder(
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ShimmerWidget(
                    height: 60,
                    width: double.infinity,
                  ),
                );
              },
              itemCount: 2);
        } else {
          int habitCount = showAll
              ? habitData.length
              : habitData.length >= 2
                  ? habitData.length
                  : 1;

          return habitData.isEmpty
              ? const Center(
                  child: Text("No habits yet!"),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: habitCount,
                  itemBuilder: (context, index) {
                    return HabitContiner(
                      index: index,
                      habitDate: habitData[index],
                    );
                  },
                );
        }
      },
    );
  }
}
