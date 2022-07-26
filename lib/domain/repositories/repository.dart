import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/error/faliure.dart';
import '../entities/todo_entity.dart';

abstract class Repository {
  Future<Either<Failure, void>> addTask(TodoInput todo);
  Future<Either<Failure, List<TodoEntity>>> getAllTasks();
  Future<Either<Failure, List<TodoEntity>>> getCompletedTasks();
  Future<Either<Failure, List<TodoEntity>>> getUnCompletedTasks();
  Future<Either<Failure, List<TodoEntity>>> getFavoriteTasks();
  Future<Either<Failure, List<TodoEntity>>> searchInTasks(String title);
  Future<Either<Failure, List<TodoEntity>>> getTasksBySpecificDate(String time);
  Future<Either<Failure, void>> editTask(TodoInput todo);
  Future<Either<Failure, void>> addToFav(AddToFavInput input);
  Future<Either<Failure, void>> completeTask(CompleteTasInput input);
  Future<Either<Failure, void>> deleteTask(int id);
}

class AddToFavInput {
  final int id;
  final int isFav;
  AddToFavInput(this.id,this.isFav);
}

class CompleteTasInput {
  final int id;
  final int isComplete;
  CompleteTasInput(this.id,this.isComplete);
}

class TodoInput extends Equatable {
  final String title;
  final bool isCompleted;
  final bool isFav;
  final int notificationId;
  final String date;
  final int color;
  final String startTime;
  final String endTime;
  final int remind;
  final String repeat;

  const TodoInput({
    required this.date,
    required this.endTime,
    required this.isFav,
    required this.color,
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
        color,
        notificationId,
        date,
        startTime,
        endTime,
        isCompleted,
        remind,
        repeat,
      ];
}
