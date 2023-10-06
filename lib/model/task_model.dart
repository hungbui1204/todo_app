import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String description;
  final String id;
  final String time;
  bool? isDone;
  bool? isDeleted;
  bool? isFavorite;
  Task(
      {required this.title,
      required this.id,
      required this.time,
      required this.description,
      this.isDone,
      this.isFavorite,
      this.isDeleted}) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
    isFavorite = isFavorite ?? false;
  }
  Task copyWith(
      {String? title,
      String? description,
      String? time,
      String? id,
      bool? isDone,
      bool? isFavorite,
      bool? isDeleted}) {
    return Task(
        title: title ?? this.title,
        description: description ?? this.description,
        id: id ?? this.id,
        time: time ?? this.time,
        isDone: isDone ?? this.isDone,
        isFavorite: isFavorite ?? this.isFavorite,
        isDeleted: isDeleted ?? this.isDeleted);
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        id: map['id'],
        time: map['time'],
        isDone: map['isDone'],
        isFavorite: map['isFavorite'],
        isDeleted: map['isDeleted']);
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'id': id,
      'time': time,
      'isDone': isDone,
      'isDeleted': isDeleted,
      'isFavorite': isFavorite,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [title, isDone, isDeleted, id, description, time, isFavorite];
}
