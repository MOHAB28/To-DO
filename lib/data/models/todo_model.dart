import '../../domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel({
    String? id,
    bool? isCompleted,
    bool? isFav,
    String? title,
    String? date,
    int? color,
    String? startTime,
    required int notificationId,
    String? endTime,
    int? remind,
    String? repeat,
  }) : super(
          id: id == null ? 0 : int.parse(id),
          isCompleted: isCompleted!,
          notificationId: notificationId,
          isFav: isFav!,
          title: title!,
          color: color!,
          startTime: startTime!,
          date: date!,
          endTime: endTime!,
          remind: remind!,
          repeat: repeat!,
        );
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'].toString(),
      date: json['date'],
      notificationId: json['notificationId'],
      color: json['color'],
      endTime: json['endTime'],
      startTime: json['startTime'],
      isCompleted: json['isCompleted'] == 0 ? false : true,
      isFav: json['isFav'] == 0 ? false : true,
      remind: json['remind'],
      repeat: json['repeat'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
      'isFav': isFav ? 1 : 0,
      'date': date,
      'notificationId' : notificationId,
      'color': color,
      'startTime': startTime,
      'endTime': endTime,
      'remind': remind,
      'repeat': repeat
    };
    return json;
  }
}
