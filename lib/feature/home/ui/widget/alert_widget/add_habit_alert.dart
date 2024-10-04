import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/feature/Auth/ui/widget/custom_button.dart';
import 'package:habit_track/feature/home/ui/widget/alert_widget/compont_widget_fort_alert.dart';
import 'package:habit_track/feature/home/ui/widget/alert_widget/edit_alert.dart';

class CreateNewHabit extends StatefulWidget {
  const CreateNewHabit({super.key});

  @override
  State<CreateNewHabit> createState() => _CreateNewHabitState();
}

class _CreateNewHabitState extends State<CreateNewHabit> {
  TextEditingController habitNameController = TextEditingController();
  String selectedHabitType = 'Everyday';

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
                nameOfAlert: 'Create New Habit',
              ),
              const SizedBox(height: 10),

              const Divider(color: Colors.black, thickness: .15),
              const SizedBox(height: 10),

              Center(
                child: Text(
                  "Challange Your Self ",
                  style: TextAppStyle.subMainTittel.copyWith(
                    fontSize: 18.sp,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: [
                          Color(0xFF08D9D6), // #08D9D6
                          Color(0xFF0083B0), // #0083B0
                        ],
                      ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //!what name habit and text
              TextPartInAlert(
                habitNameController: habitNameController,
                hintText: 'Habit Name',
              ),
              const SizedBox(height: 15),
              //!drop dwon
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
              if (selectedHabitType == 'Custom') CustomHabitType(),
              const SizedBox(height: 18),
              //!button update
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
