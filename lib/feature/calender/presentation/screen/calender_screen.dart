import 'package:flutter/material.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/feature/calender/presentation/screen/widgets/calnder_body.dart';
import 'package:habit_track/feature/calender/presentation/screen/widgets/row_body.dart';

class HabitCalendar extends StatelessWidget {
  const HabitCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now(); // Get current day

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${today.day}-${today.month}- ${today.year}",
                style: TextAppStyle.subTittel,
              ),
              const Text("Journaling everyday",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
          CalnderBodyWidget(
            today: today,
          ),
          const Divider(
            color: Colors.grey,
          ),
          const RowBody(),
        ],
      ),
    );
  }
}
