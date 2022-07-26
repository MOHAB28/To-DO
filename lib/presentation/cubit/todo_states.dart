
import 'package:equatable/equatable.dart';

import '../../domain/entities/todo_entity.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class AddTaskLoading extends TodoState {}

class AddTaskSuccess extends TodoState {}

class AddTaskFailure extends TodoState {}

class GetAllTasksLoading extends TodoState {}

class GetAllTasksSuccess extends TodoState {
  final List<TodoEntity> todos;
  const GetAllTasksSuccess(this.todos);
}

class GetAllTasksFailure extends TodoState {}

class GetCompleteTasksLoading extends TodoState {}

class GetCompleteTasksSuccess extends TodoState {
  final List<TodoEntity> todos;
  const GetCompleteTasksSuccess(this.todos);
}

class GetCompleteTasksFailure extends TodoState {}

class GetUnCompleteTasksLoading extends TodoState {}

class GetUnCompleteTasksSuccess extends TodoState {
  final List<TodoEntity> todos;
  const GetUnCompleteTasksSuccess(this.todos);
}

class GetUnCompleteTasksFailure extends TodoState {}

class GetFavoritesTasksLoading extends TodoState {}

class GetFavoritesTasksSuccess extends TodoState {
  final List<TodoEntity> todos;
  const GetFavoritesTasksSuccess(this.todos);
}

class GetFavoritesTasksFailure extends TodoState {}

class GetTasksBySpecificDateLoading extends TodoState {}

class GetTasksBySpecificDateSuccess extends TodoState {
  final List<TodoEntity> todos;
  const GetTasksBySpecificDateSuccess(this.todos);
}

class GetTasksBySpecificDateFailure extends TodoState {}

class SearchInTasksLoading extends TodoState {}

class SearchInTasksSuccess extends TodoState {
  final List<TodoEntity> todos;
  const SearchInTasksSuccess(this.todos);
}

class SearchInTasksFailure extends TodoState {}

class EditTaskLoading extends TodoState {}

class EditTaskSuccess extends TodoState {}

class EditTaskFailure extends TodoState {}

class AddToFavLoading extends TodoState {}

class AddToFavSuccess extends TodoState {}

class AddToFavFailure extends TodoState {}

class ComoleteTheTaskLoading extends TodoState {}

class ComoleteTheTaskSuccess extends TodoState {}

class ComoleteTheTaskFailure extends TodoState {}

class DeleteTheTaskLoading extends TodoState {}

class DeleteTheTaskSuccess extends TodoState {}

class DeleteTheTaskFailure extends TodoState {}

class ChangeCurrentSelectedDayState extends TodoState {}




