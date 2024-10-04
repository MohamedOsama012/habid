import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/theme/color.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/feature/home/ui/widget/to_do_widgets/habit_continer.dart';

class TabBarToDo extends StatefulWidget {
  TabBarToDo({super.key});

  @override
  State<TabBarToDo> createState() => _TabBarToDoState();
}

class _TabBarToDoState extends State<TabBarToDo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs: "To do" and "Not to do"
      child: Container(
        color: Colors.white,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.white.withOpacity(.5),
            bottom: TabBar(
              unselectedLabelStyle: TextAppStyle.subTittel.copyWith(
                fontSize: 14.sp,
              ),
              unselectedLabelColor: AppColor.subText,
              labelColor: Colors.black,
              labelStyle: TextAppStyle.mainTittel.copyWith(fontSize: 30.sp),
              indicatorColor: Colors.white,
              dividerColor: Colors.white,
              tabs: [
                Tab(
                  height: 50.h,
                  text: 'To do',
                ),
                Tab(
                  height: 50.h,
                  text: 'Not to do',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              //! Widget 1: The custom card with checkbox, text, and 3-dot icon
              ListView.builder(
                itemBuilder: (context, index) {
                  return const HabitContiner(
                    isDone: true,
                  );
                },
                itemCount: 2,
              ),
              //! Widget 2: same
              ListView.builder(
                itemBuilder: (context, index) {
                  return const HabitContiner(
                    isDone: false,
                  );
                },
                itemCount: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
