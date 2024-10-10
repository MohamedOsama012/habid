import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_track/core/global/global_widget/app_stuts.dart';
import 'package:habit_track/core/theme/color.dart';
import 'package:habit_track/feature/Auth/ui/widget/custom_button.dart';
import 'package:habit_track/feature/home/cubit/cubit/home_cubit.dart';
import 'package:habit_track/feature/home/data/model/habit_model.dart';
import 'package:habit_track/feature/home/ui/widget/alert_widget/compont_widget_fort_alert.dart';
import 'package:habit_track/main.dart';

class EditHabitDialog extends StatefulWidget {
  EditHabitDialog({Key? key, required this.habitDate}) : super(key: key);
  HabitModel habitDate;

  @override
  State<EditHabitDialog> createState() => _EditHabitDialogState();
}

class _EditHabitDialogState extends State<EditHabitDialog> {
  TextEditingController habitNameController = TextEditingController();
  String selectedHabitType = 'Everyday';
  List<String> customDays = [];

  @override
  void initState() {
    super.initState();

    // Pre-fill with the existing habit name
    habitNameController.text = widget.habitDate.name;

    // Set initial habit type based on the habitDate
    if (widget.habitDate.period == 'Custom') {
      selectedHabitType = 'Custom';
      customDays = widget.habitDate.customDays ?? [];
    } else {
      selectedHabitType = 'Everyday';
    }
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
                nameOfAlert: 'Edit Habit',
              ),
              const Divider(color: Colors.black, thickness: .15),
              const SizedBox(height: 10),
              //!what name habit and text
              TextPartInAlert(
                habitNameController: habitNameController,
                hintText: 'Habit Name',
                hintHabiText: widget.habitDate.name,
              ),
              const SizedBox(height: 15),
              //!drop down
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Habit Type",
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
                      items: <String>['Everyday', 'Custom']
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
              //!custom weekly
              if (selectedHabitType == 'Custom')
                CustomHabitType(
                  initialSelectedDays:
                      customDays, // Pass initial custom days here
                  onDaysSelected: (selectedDays) {
                    customDays.clear();
                    customDays.addAll(selectedDays);
                  },
                ),
              const SizedBox(height: 18),
              //!button update
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return state is UpdateHabitLooding
                      ? Center(child: CircularProgressIndicator())
                      : CustomButton(
                          buttonName: 'Update',
                          onPressed: () {
                            // Validation for custom habit type with empty custom days
                            if (selectedHabitType == 'Custom' &&
                                customDays.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                // ignore: prefer_const_constructors
                                SnackBar(
                                  content: const Text(
                                      "Please select at least one custom day"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return; // Prevent further execution if validation fails
                            }
                            context.read<HomeCubit>().updateHabit(
                                  habitId: widget.habitDate.habitId,
                                  habitName: habitNameController.text.isEmpty
                                      ? widget.habitDate.name
                                      : habitNameController.text,
                                  period: selectedHabitType,
                                  customDays: customDays,
                                );
                          },
                        );
                },
              ),

              const SizedBox(height: 10),
              //!delete
              BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {
                  if (state is DeleteHabitFail || state is UpdateHabitFail) {
                    Navigator.pop(context);
                    AppStuts.showCustomSnackBar(
                        context, "Error", Icons.close, false);
                  } else if (state is DeleteHabitSuscsses) {
                    Navigator.pop(context);

                    AppStuts.showCustomSnackBar(
                        context,
                        "${state.massage} '${widget.habitDate.name}' successful",
                        Icons.check,
                        true);
                  } else if (state is UpdateHabitSuscsses) {
                    Navigator.pop(context);

                    AppStuts.showCustomSnackBar(
                        context,
                        "${state.massage} '${habitNameController.text.isEmpty ? widget.habitDate.name : habitNameController.text}' successful",
                        Icons.check,
                        true);
                  }
                },
                builder: (context, state) {
                  return state is DeleteHabitLooding
                      ? const Center(child: CircularProgressIndicator())
                      : TextButton(
                          onPressed: () async {
                            await context
                                .read<HomeCubit>()
                                .deletHabit(habitId: widget.habitDate.habitId);
                          },
                          child: const Center(
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
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

class CustomHabitType extends StatefulWidget {
  final Function(List<String>) onDaysSelected;
  final List<String> initialSelectedDays;

  CustomHabitType({
    super.key,
    required this.onDaysSelected,
    required this.initialSelectedDays,
  });

  @override
  State<CustomHabitType> createState() => _CustomHabitTypeState();
}

class _CustomHabitTypeState extends State<CustomHabitType> {
  final List<bool> selectedWeekdays = List.filled(7, false);
  final List<String> weekdays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  @override
  void initState() {
    super.initState();

    // Initialize selectedWeekdays based on initialSelectedDays
    for (int i = 0; i < weekdays.length; i++) {
      if (widget.initialSelectedDays.contains(weekdays[i])) {
        selectedWeekdays[i] = true;
      }
    }
  }

  void _notifyDaysSelected() {
    List<String> selectedDays = [];
    for (int i = 0; i < selectedWeekdays.length; i++) {
      if (selectedWeekdays[i]) {
        selectedDays.add(weekdays[i]);
      }
    }
    widget.onDaysSelected(selectedDays);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(weekdays.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedWeekdays[index] = !selectedWeekdays[index];
            });
            _notifyDaysSelected();
          },
          child: Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  gradient: selectedWeekdays[index]
                      ? const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            AppColor.checkBoxDoneHabitColor,
                            AppColor.secondCheckBoxDoneHabitColor,
                          ],
                        )
                      : null,
                  border: selectedWeekdays[index]
                      ? null
                      : Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: selectedWeekdays[index]
                    ? const Icon(Icons.check, color: Colors.white)
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 5),
              Text(
                weekdays[index].substring(0, 3),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        );
      }),
    );
  }
}
