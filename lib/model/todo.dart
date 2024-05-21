class Todo {
  final int userId;
  final int id;
  final String title;
  bool completed;

  Todo(
      {required this.userId,
      required this.id,
      required this.title,
      required this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed']);
}
