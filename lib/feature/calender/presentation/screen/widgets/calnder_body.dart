import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_track/core/global/global_widget/build_circlar_date.dart';
import 'package:habit_track/core/theme/screen_size.dart';
import 'package:habit_track/feature/calender/data/data_source/calender_data_source.dart';
import 'package:habit_track/feature/calender/data/repo/calnder_repo_impl.dart';
import 'package:habit_track/feature/calender/presentation/screen/habit_detials_screen.dart';
import 'package:habit_track/routes/routes_name.dart';
import 'package:habit_track/service/firebase_service.dart';

class CalnderBodyWidget extends StatefulWidget {
  const CalnderBodyWidget({super.key, required this.today});
  final DateTime today;
  @override
  State<CalnderBodyWidget> createState() => _CalnderBodyWidgetState();
}

class _CalnderBodyWidgetState extends State<CalnderBodyWidget> {
  EventList<Event> habitStatusMap = EventList<Event>(events: {});
  CalenderRepoImpl calenderDataSource = CalenderRepoImpl(
      calenderDataSource:
          CalenderDataSourceImpl(firebaseService: FirebaseService()));
  @override
  void initState() {
    super.initState();
    _loadHabitData(); // Load habit data on initialization
  }

  Future<void> _loadHabitData() async {
    final dailyProgress = await calenderDataSource
        .lodaAllDateHabit(); // Fetch data from Firestore
    setState(() {
      habitStatusMap = EventList<Event>(events: dailyProgress);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppScreenUtil.getResponsiveHeight(context, .46),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        todayButtonColor: habitStatusMap.events[widget.today] == null
            ? Colors.blue
            : Colors.transparent,
        markedDatesMap: habitStatusMap,
        markedDateShowIcon: true,
        markedDateIconMaxShown: 1,
        markedDateIconBuilder: (event) =>
            _getDayDecoration(event.date, widget.today),
        onDayPressed: (DateTime date, List<Event> events) {
          if (events.isNotEmpty) {
            _navigateToHabitDetailsPage(context, date);
          } else {
            _showNoHabitAlert(context, date);
          }
        },
      ),
    );
  }

  // Get decoration for the day based on whether it's today, completed, or incomplete
  Widget? _getDayDecoration(DateTime date, DateTime today) {
    // If it's today, highlight in blue
    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return buildCircularDayDecoration(
          date.day, Colors.blue); // Blue for today
    } else if (habitStatusMap.getEvents(date).isNotEmpty) {
      return habitStatusMap
          .getEvents(date)[0]
          .icon; // Use the icon for completed/incomplete
    } else {
      return buildCircularDayDecoration(
          date.day, Colors.red); // Red for incomplete
    }
  }

  // Navigate to a new screen that shows habit details for the selected day
  void _navigateToHabitDetailsPage(BuildContext context, DateTime date) {
    context.push(Routes.detialsHabitScreen, extra: date);
  }

  // Show an alert when no habit data is found for the selected date
  void _showNoHabitAlert(BuildContext context, DateTime date) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("No Habit Found"),
          content: Text(
              "No habit data available for ${date.day}-${date.month}-${date.year}."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
