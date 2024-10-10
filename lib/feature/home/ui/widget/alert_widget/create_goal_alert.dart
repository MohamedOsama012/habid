import 'package:flutter/material.dart';
import 'package:habit_track/core/global/global_widget/app_stuts.dart';
import 'package:habit_track/feature/Auth/ui/widget/custom_button.dart';
import 'package:habit_track/feature/home/cubit/cubit/home_cubit.dart';
import 'package:habit_track/feature/home/cubit/goal_cubit/cubit/goal_cubit.dart';
import 'package:habit_track/feature/home/ui/widget/alert_widget/compont_widget_fort_alert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_track/feature/home/data/model/habit_model.dart';

class CreateNewGoal extends StatefulWidget {
  const CreateNewGoal({super.key});

  @override
  State<CreateNewGoal> createState() => _CreateNewGoalState();
}

class _CreateNewGoalState extends State<CreateNewGoal> {
  TextEditingController goalNameControllar = TextEditingController();
  String selectedHabitType = '1 week (7 Days)';
  String? selectedHabitName; // To store the selected habit name
  String? habitId;
  @override
  void initState() {
    super.initState();
    // Fetch all habits when this widget is initialized
    context.read<GoalCubit>().getAllHabitInSystem();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //!top part
              const TopPartInAlert(
                nameOfAlert: 'Create New Goal',
              ),
              const SizedBox(height: 10),

              const Divider(color: Colors.black, thickness: .15),
              const SizedBox(height: 10),

              //!what name habit and text
              TextPartInAlert(
                habitNameController: goalNameControllar,
                hintText: 'Goal Name',
              ),
              const SizedBox(height: 15),

              //! Habit name dropdown (fetched from Firebase)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Habit Name",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  BlocBuilder<GoalCubit, GoalState>(
                    builder: (context, state) {
                      if (state is GetHabitForGoalSucsess) {
                        // Create dropdown items based on the habit data fetched
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: DropdownButtonFormField<String>(
                            dropdownColor: Colors.grey[200],
                            value: selectedHabitName,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedHabitName = newValue;
                              });
                            },
                            items:
                                state.habitData.map<DropdownMenuItem<String>>(
                              (HabitModel habit) {
                                return DropdownMenuItem<String>(
                                  value: habit.name,
                                  onTap: () {
                                    habitId = habit.habitId;
                                  },
                                  child: Text(habit.name),
                                );
                              },
                            ).toList(),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 30,
                            ),
                          ),
                        );
                      } else if (state is GetHabitForGoaFail) {
                        return const Text('Failed to load habits');
                      } else {
                        // Show a loading spinner while data is being fetched
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 25),

              //!drop down period
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Period",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Container(
                    width: 180,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8)),
                    child: DropdownButtonFormField<String>(
                      dropdownColor: Colors.grey[200],
                      value: selectedHabitType,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedHabitType = newValue!;
                        });
                      },
                      items: <String>['1 week (7 Days)', '1 Month (30 Days)']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down_outlined,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              //! Create button
              BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {
                  if (state is CreatGoalFail) {
                    Navigator.pop(context);
                    AppStuts.showCustomSnackBar(
                        context, "Error", Icons.close, false);
                  } else if (state is CreatGoalSucsses) {
                    Navigator.pop(context);

                    AppStuts.showCustomSnackBar(
                        context, "Creat Goal successful", Icons.check, true);
                  }
                },
                builder: (context, state) {
                  return state is CreatGoalLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          buttonName: 'Create',
                          onPressed: () {
                            print('Habit Name: $habitId');
                            print('Goal Period: $selectedHabitType');
                            print('Goal Name: ${goalNameControllar.text}');
                            context.read<HomeCubit>().creatGoal(
                                name: goalNameControllar.text,
                                period: selectedHabitType,
                                habitId: habitId);
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
