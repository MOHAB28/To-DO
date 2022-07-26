import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/faliure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class TodoUsecaseInput extends Equatable {
  final String title;
  final bool isCompleted;
  final bool isFav;
  final int notificationId;
  final int color;
  final String date;
  final String startTime;
  final String endTime;
  final int remind;
  final String repeat;

  const TodoUsecaseInput({
    required this.date,
    required this.endTime,
    required this.color,
    required this.isFav,
    required this.notificationId,
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
        color,
        notificationId,
        endTime,
        isCompleted,
        remind,
        repeat,
      ];
}
