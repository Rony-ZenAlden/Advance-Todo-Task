class TaskModel {
  int? id;
  String? taskName;
  String? taskDetail;
  String? date;

  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskDetail,
    required this.date,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      taskName: json['task_name'],
      taskDetail: json['task_detail'],
      date: json['date'],
    );
  }
}
