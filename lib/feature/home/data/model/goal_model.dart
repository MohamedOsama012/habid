class Goal {
  String? name;
  int? total;
  int? currentProgress;
  String? habitId;
  Goal({this.name, this.total, this.currentProgress, this.habitId});

  Goal.fromJson(Map<String, dynamic> json) {
    name = json['goal_name'];
    total = json['total_day'];
    currentProgress = json['done_day'];
    habitId = json['habit_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['total'] = this.total;
    data['progress'] = this.currentProgress;
    return data;
  }
}
