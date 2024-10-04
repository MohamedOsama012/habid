import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:habit_track/core/theme/color.dart';
import 'package:habit_track/core/theme/screen_size.dart';
import 'package:habit_track/core/theme/style.dart';

class HabitCalendar extends StatefulWidget {
  @override
  _HabitCalendarState createState() => _HabitCalendarState();
}

class _HabitCalendarState extends State<HabitCalendar> {
  // Example data: completed habits (green) and incomplete habits (red)
  EventList<Event> habitStatusMap = EventList<Event>(
    events: {
      // Green days (completed habits)
      DateTime(2024, 10, 1): [
        Event(
            date: DateTime(2024, 10, 1),
            title: 'Completed Habit',
            icon: _buildCircularDayDecoration(
                1, AppColor.secondCheckBoxDoneHabitColor))
      ],
      DateTime(2024, 10, 2): [
        Event(
          date: DateTime(2024, 10, 2),
          title: 'Completed Habit',
          icon: _buildCircularDayDecoration(
              2, AppColor.secondCheckBoxDoneHabitColor), // Green day
        ),
      ],
      // Red days (incomplete habits)
      DateTime(2024, 10, 3): [
        Event(
          date: DateTime(2024, 10, 3),
          title: 'Incomplete Habit',
          icon: _buildCircularDayDecoration(3, Colors.red), // Red day
        ),
      ],
    },
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Oct. 1 2024",
                  style: TextAppStyle.subTittel,
                ),
                Text("Journaling everyday",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
          ),
          Container(
            height: AppScreenUtil.getResponsiveHeight(context, .46),
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: CalendarCarousel<Event>(
              todayButtonColor: Colors.blue, // Blue for the current day
              markedDatesMap: habitStatusMap, // Custom marked dates for habits
              markedDateShowIcon: true, // Show custom icons (green/red days)
              markedDateIconMaxShown: 1, // Ensure only one icon per day
              markedDateIconBuilder: (event) =>
                  event.icon, // Use the custom day decoration
              onDayPressed: (DateTime date, List<Event> events) {
                // Check if the day is marked (green or red) and navigate
                if (events.isNotEmpty) {
                  // Navigate to a habit details page
                  _navigateToHabitDetailsPage(context, date);
                } else {
                  // Show alert when no habit is found for the selected date
                  _showNoHabitAlert(context, date);
                }
              },
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(Colors.blue, "Current Day"),
              SizedBox(width: 10),
              _buildLegendItem(
                  const Color.fromARGB(255, 147, 221, 149), "Completed"),
              SizedBox(width: 10),
              _buildLegendItem(Colors.red, "Incomplete"),
            ],
          ),
        ],
      ),
    );
  }

  // Build a small legend item with circular color and text
  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Helper method to create the circular decoration with the day number
  static Widget _buildCircularDayDecoration(int day, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        "$day",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Navigate to a new screen that shows habit details for the selected day
  void _navigateToHabitDetailsPage(BuildContext context, DateTime date) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HabitDetailsPage(date: date),
      ),
    );
  }

  // Show an alert when no habit data is found for the selected date
  void _showNoHabitAlert(BuildContext context, DateTime date) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No Habit Found"),
          content: Text(
              "No habit data available for ${date.day}-${date.month}-${date.year}."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

class HabitDetailsPage extends StatelessWidget {
  final DateTime date;

  HabitDetailsPage({required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Habit Details for ${date.day}-${date.month}-${date.year}"),
      ),
      body: Center(
        child: Text(
          "Habit details for ${date.day}-${date.month}-${date.year}",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
