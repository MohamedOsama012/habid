import 'package:flutter/material.dart';
import 'package:habit_track/core/theme/color.dart';
import 'package:habit_track/feature/Auth/ui/widget/custom_button.dart';
import 'package:habit_track/feature/home/ui/widget/alert_widget/compont_widget_fort_alert.dart';

class EditHabitDialog extends StatefulWidget {
  EditHabitDialog({Key? key}) : super(key: key);

  @override
  State<EditHabitDialog> createState() => _EditHabitDialogState();
}

class _EditHabitDialogState extends State<EditHabitDialog> {
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
                nameOfAlert: 'Edit Habit',
              ),
              const Divider(color: Colors.black, thickness: .15),
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
                buttonName: 'Update',
                onPressed: () {
                  // Handle the update logic
                },
              ),
              const SizedBox(height: 10),
              //!delet
              TextButton(
                onPressed: () {
                  // Handle delete logic
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomHabitType extends StatefulWidget {
  CustomHabitType({super.key});

  @override
  State<CustomHabitType> createState() => _CustomHabitTypeState();
}

class _CustomHabitTypeState extends State<CustomHabitType> {
  final List<bool> selectedWeekdays = List.filled(7, false);

  final List<String> weekdays = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat'
  ];

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
                weekdays[index],
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        );
      }),
    );
  }
}
