import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/feature/home/ui/widget/to_do_widgets/tapbar.dart';

class ToDoWidget extends StatelessWidget {
  const ToDoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Container(
        width: double.infinity,
        height: 220.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(57, 158, 158, 158), // Shadow color
              blurRadius: 10,
              offset: Offset(0, 8), // Horizontal and vertical offset
            ),
          ],
        ),
        //here body
        child: Column(
          children: [
            //!1
            Expanded(child: TabBarToDo()),
            //!2
            TextButton(
              onPressed: () {},
              child: Text(
                'show more',
                style: TextAppStyle.subTittel,
              ),
            )
          ],
        ),
      ),
    );
  }
}
