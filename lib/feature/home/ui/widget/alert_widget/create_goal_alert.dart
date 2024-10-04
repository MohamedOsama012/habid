import 'package:flutter/material.dart';
import 'package:habit_track/feature/Auth/ui/widget/custom_button.dart';
import 'package:habit_track/feature/home/ui/widget/alert_widget/compont_widget_fort_alert.dart';

class CreatNewGoal extends StatefulWidget {
  const CreatNewGoal({super.key});

  @override
  State<CreatNewGoal> createState() => _CreatNewGoalState();
}

class _CreatNewGoalState extends State<CreatNewGoal> {
  TextEditingController habitNameController = TextEditingController();
  String selectedHabitType = '1 week (7 Days)';
  String selectedname = '5 pray';

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
                habitNameController: habitNameController,
                hintText: 'Goal Name',
              ),
              const SizedBox(height: 15),
              //! habitname drop
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Habit Name ",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8)),
                    child: DropdownButtonFormField<String>(
                      dropdownColor: Colors.grey[200],
                      value: selectedname,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedname = newValue!;
                        });
                      },
                      items: <String>['5 pray', 'eat health']
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
              const SizedBox(height: 25),

              //!drop dwon period
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Period ",
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
              //!button create
              CustomButton(
                buttonName: 'Create',
                onPressed: () {
                  // Handle the update logic
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
