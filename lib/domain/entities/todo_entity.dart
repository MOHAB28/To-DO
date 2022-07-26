import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final int id;
  final String title;
  final int color;
  final int notificationId;
  final bool isCompleted;
  final bool isFav;
  final String date;
  final String startTime;
  final String endTime;
  final int remind;
  final String repeat;

  const TodoEntity({
    required this.date,
    required this.endTime,
    required this.isFav,
    required this.color,
    required this.notificationId,
    required this.id,
    required this.isCompleted,
    required this.remind,
    required this.repeat,
    required this.startTime,
    required this.title,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    date,
    startTime,
    notificationId,
    color,
    endTime,
    isCompleted,
    remind,
    repeat,
  ];
}
