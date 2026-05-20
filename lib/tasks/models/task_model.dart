class TaskModel {
  String? id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;
  final String userId;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
    required this.userId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
      isCompleted: map['isCompleted'] ?? false,
      userId: map['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'isCompleted': isCompleted,
      'userId': userId,
    };
  }
}
