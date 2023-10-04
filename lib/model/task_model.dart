import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String description;
  final String id;
  final String time;
  bool? isDone;
  bool? isDeleted;
  Task(
      {required this.title,
      required this.id,
      required this.time,
      required this.description,
      this.isDone,
      this.isDeleted}) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }
  Task copyWith(
      {String? title,
      String? description,
      String? time,
      String? id,
      bool? isDone,
      bool? isDeleted}) {
    return Task(
        title: title ?? this.title,
        description: description ?? this.description,
        id: id ?? this.id,
        time: time ?? this.time,
        isDone: isDone ?? this.isDone,
        isDeleted: isDeleted ?? this.isDeleted);
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        id: map['id'],
        time: map['time'],
        isDone: map['isDone'],
        isDeleted: map['isDeleted']);
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'id': id,
      'time': time,
      'isDone': isDone,
      'isDeleted': isDeleted
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [title, isDone, isDeleted, id, description, time];
}
