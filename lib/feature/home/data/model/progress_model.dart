class ProgressModel {
  bool completed; // If the habit was completed on that date

  ProgressModel({
    required this.completed,
  });

  // Factory method to create ProgressModel from JSON
  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      completed: json['completed'] as bool,
    );
  }

  // Convert ProgressModel back to JSON
  Map<String, dynamic> toJson() {
    return {
      'completed': completed,
    };
  }
}
