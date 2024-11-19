import 'package:habit_track/feature/home/data/model/goal_model.dart';
import 'package:habit_track/feature/home/data/model/progress_model.dart';

class HabitModel {
  String name;
  String period; // Period can be "daily" or "custom"
  List<String> customDays; // List of specific days if period is custom
  List<ProgressModel>? progress; // List of progress records
  String habitId;
  Goal? goal;

  HabitModel({
    required this.name,
    required this.period,
    required this.customDays,
    required this.habitId,
    this.goal,
    this.progress, // Initialize progress
  });

  // Factory method to create HabitModel from JSON
  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
        name: json['habit_name'] as String,
        habitId: json['habit_id'] as String,
        period: json['period'] as String,
        customDays: List<String>.from(json['customDays'] as List),
        goal: json['goal'] != null ? Goal.fromJson(json['goal']) : null
        // Map progress records
        );
  }
}
