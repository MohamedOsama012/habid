import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_track/feature/home/data/model/habit_model.dart';
import 'package:habit_track/feature/home/presentation/cubit/habit_cubit/habit_cubit.dart';
import 'package:habit_track/feature/home/presentation/ui/widgets/to_do_widgets/habit_continer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/theme/color.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/feature/home/presentation/cubit/habit_cubit/habit_cubit.dart';
import 'package:habit_track/feature/home/presentation/ui/widgets/to_do_widgets/habit_continer.dart';
import 'package:habit_track/feature/home/presentation/ui/widgets/to_do_widgets/to_do_list.dart';
import 'package:habit_track/feature/home/presentation/ui/widgets/to_do_widgets/uncomplit_list.dart';

class TabBarToDo extends StatefulWidget {
  final bool showAll;

  const TabBarToDo({super.key, required this.showAll});

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
              labelStyle: TextAppStyle.mainTittel.copyWith(fontSize: 25.sp),
              indicatorColor: Colors.white,
              dividerColor: Colors.white,
              tabs: [
                Tab(
                  height: 50.h,
                  text: 'To Do',
                ),
                Tab(
                  height: 50.h,
                  text: 'Uncomplete',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              //! Widget 1: To Do Habits List
              ToDoHabitsList(showAll: widget.showAll),

              //! Widget 2: Not To Do Habits List with Animation
              NotToDoHabitsList(),
            ],
          ),
        ),
      ),
    );
  }
}
