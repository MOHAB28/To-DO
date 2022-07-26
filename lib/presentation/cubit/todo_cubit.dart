import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_task2/presentation/cubit/todo_states.dart';
import '../../core/services/notification_services.dart';
import '../../core/usecase/usecase.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/usecases/add_task_usecase.dart';
import '../../domain/usecases/add_to_fav_usecase.dart';
import '../../domain/usecases/complete_task_usecase.dart';
import '../../domain/usecases/delete_task_usecase.dart';
import '../../domain/usecases/edit_task_usecase.dart';
import '../../domain/usecases/get_uncompleted_taks_usecase.dart';
import '../../domain/usecases/search_in_tasks_usecase.dart';
import '../../domain/usecases/get_all_tasks_usecase.dart';
import '../../domain/usecases/get_complete_tasks_usecase.dart';
import '../../domain/usecases/get_fav_tasks_usecase.dart';
import '../../domain/usecases/get_tasks_by_specific_usecase.dart';

class CubitInput {
  final String title;
  final bool isCompleted;
  final bool isFav;
  final int color;
  final String date;
  final int notificationId;
  final String startTime;
  final String endTime;
  final int remind;
  final String repeat;

  const CubitInput({
    required this.date,
    required this.color,
    required this.endTime,
    required this.isFav,
    required this.notificationId,
    required this.isCompleted,
    required this.remind,
    required this.repeat,
    required this.startTime,
    required this.title,
  });
}

class TodoBloc extends Cubit<TodoState> {
  final AddTaskUseCase addTaskUseCase;
  final GetAllTasksUsecase allTasksUsecase;
  final GetCompletedTasksUsecase completedTasksUsecase;
  final GetUnCompletedTasksUsecase getUnCompletedTasksUsecase;
  final GetFavoriteTasksUsecase favoriteTasksUsecase;
  final GetTasksBySpecificDateUsecase tasksBySpecificDateUsecase;
  final EditTaskUsecase editTaskUsecase;
  final AddToFavUsecase addToFavUsecase;
  final CompleteTaskUsecase completeTaskUsecase;
  final SearchInTasksUsecase searchInTasksUsecase;
  final DeleteTaskUsecase deleteTaskUsecase;
  TodoBloc({
    required this.addTaskUseCase,
    required this.addToFavUsecase,
    required this.allTasksUsecase,
    required this.completeTaskUsecase,
    required this.completedTasksUsecase,
    required this.deleteTaskUsecase,
    required this.editTaskUsecase,
    required this.favoriteTasksUsecase,
    required this.getUnCompletedTasksUsecase,
    required this.searchInTasksUsecase,
    required this.tasksBySpecificDateUsecase,
  }) : super(TodoInitial());
  static TodoBloc get(BuildContext context) =>
      BlocProvider.of<TodoBloc>(context);

  List<TodoEntity> allTasks = [];
  List<TodoEntity> completeTasks = [];
  List<TodoEntity> unCompleteTasks = [];
  List<TodoEntity> favTasks = [];
  List<TodoEntity> specificDatesTasks = [];
  List<TodoEntity> searchedTasks = [];
  int selectedIndex = 0;

  Future<void> addTasks(CubitInput input) async {
    emit(AddTaskLoading());
    NotificationService notificationService = NotificationService();
    DateTime date = DateFormat.jm()
        .parse(input.startTime.toString())
        .subtract(Duration(minutes: input.remind));
    var myTime = DateFormat('HH:mm').format(date);
    await notificationService
        .scheduleNotifications(
      time: input.startTime,
      repeat: input.repeat,
      body: input.title,
      hour: int.parse(myTime.toString().split(':')[0]),
      minute: int.parse(myTime.toString().split(':')[1]),
    )
        .whenComplete(() async {
      final successOrFailure = await addTaskUseCase(
        TodoUsecaseInput(
          date: input.date,
          notificationId: input.notificationId,
          endTime: input.endTime,
          color: input.color,
          isCompleted: input.isCompleted,
          isFav: input.isFav,
          remind: input.remind,
          repeat: input.repeat,
          startTime: input.startTime,
          title: input.title,
        ),
      );
      successOrFailure.fold(
        (failure) => emit(AddTaskFailure()),
        (done) {
          increaseId();
          emit(AddTaskSuccess());
        },
      );
    });
  }

  Future<void> editTask(CubitInput input) async {
    emit(EditTaskLoading());
    NotificationService notificationService = NotificationService();
    await notificationService
        .cancelNotifications(input.notificationId)
        .whenComplete(() async {
      DateTime date = DateFormat.jm()
          .parse(input.startTime.toString())
          .subtract(Duration(minutes: input.remind));
      var myTime = DateFormat('HH:mm').format(date);
      await notificationService
          .scheduleNotifications(
        time: input.startTime,
        repeat: input.repeat,
        body: input.title,
        hour: int.parse(myTime.toString().split(':')[0]),
        minute: int.parse(myTime.toString().split(':')[1]),
      )
          .whenComplete(() async {
        final successOrFailure = await editTaskUsecase(
          TodoUsecaseInput(
            date: input.date,
            notificationId: input.notificationId,
            endTime: input.endTime,
            color: input.color,
            isCompleted: input.isCompleted,
            isFav: input.isFav,
            remind: input.remind,
            repeat: input.repeat,
            startTime: input.startTime,
            title: input.title,
          ),
        );
        successOrFailure.fold(
          (failure) => emit(EditTaskFailure()),
          (done) {
            emit(EditTaskSuccess());
          },
        );
      });
    });
  }

  Future<void> getAllTasks(String where) async {
    allTasks = [];
    emit(GetAllTasksLoading());
    final successOrFailure = await allTasksUsecase(NoParams());
    successOrFailure.fold(
      (failure) => emit(GetAllTasksFailure()),
      (todos) {
        allTasks.addAll(todos);
        debugPrint(where);
        emit(GetAllTasksSuccess(todos));
      },
    );
  }

  void getCompletedTasks() async {
    completeTasks = [];
    emit(GetCompleteTasksLoading());
    final successOrFailure = await completedTasksUsecase(NoParams());
    successOrFailure.fold(
      (failure) => emit(GetCompleteTasksFailure()),
      (todos) {
        completeTasks.addAll(todos);
        emit(GetCompleteTasksSuccess(todos));
      },
    );
  }

  void getUncompletedTasks() async {
    unCompleteTasks = [];
    emit(GetUnCompleteTasksLoading());
    final successOrFailure = await getUnCompletedTasksUsecase(NoParams());
    successOrFailure.fold(
      (failure) => emit(GetUnCompleteTasksFailure()),
      (todos) {
        unCompleteTasks.addAll(todos);
        emit(GetUnCompleteTasksSuccess(todos));
      },
    );
  }

  void getFavTasks() async {
    favTasks = [];
    emit(GetFavoritesTasksLoading());
    final successOrFailure = await favoriteTasksUsecase(NoParams());
    successOrFailure.fold((failure) => emit(GetFavoritesTasksFailure()),
        (todos) {
      favTasks.addAll(todos);
      emit(GetFavoritesTasksSuccess(todos));
    });
  }

  void getTasksWithSpecificDates(String time) async {
    specificDatesTasks = [];
    emit(GetTasksBySpecificDateLoading());
    final successOrFailure = await tasksBySpecificDateUsecase(time);
    successOrFailure.fold(
      (failure) => emit(GetTasksBySpecificDateFailure()),
      (todos) {
        emit(GetTasksBySpecificDateSuccess(todos));
      },
    );
  }

  void searchInTasks(String title) async {
    searchedTasks = [];
    emit(SearchInTasksLoading());
    final successOrFailure = await searchInTasksUsecase(title);
    successOrFailure.fold(
      (failure) => emit(SearchInTasksFailure()),
      (todos) {
        searchedTasks.addAll(todos);
        emit(SearchInTasksSuccess(todos));
      },
    );
  }

  Future<void> addToFav({
    required int id,
    required int isFav,
  }) async {
    emit(AddToFavLoading());
    final successOrFailure =
        await addToFavUsecase(AddToFavUsecaseInput(id, isFav));
    successOrFailure.fold(
      (failure) => emit(AddToFavFailure()),
      (done) {
        emit(AddToFavSuccess());
      },
    );
  }

  Future<void> completeTheTask({
    required int id,
    required int isComplete,
  }) async {
    emit(ComoleteTheTaskLoading());
    final successOrFailure =
        await completeTaskUsecase(CompleteTasUseCaseInput(id, isComplete));
    successOrFailure.fold(
      (failure) => emit(ComoleteTheTaskFailure()),
      (done) {
        emit(ComoleteTheTaskSuccess());
      },
    );
  }

  Future<void> deletTheTask({
    required int id,
    required int notificationId,
  }) async {
    emit(DeleteTheTaskLoading());
    NotificationService notificationService = NotificationService();
    await notificationService
        .cancelNotifications(notificationId)
        .whenComplete(() async {
      final successOrFailure = await deleteTaskUsecase(id);
      successOrFailure.fold(
        (fialure) => emit(DeleteTheTaskFailure()),
        (done) async {
          allTasks.removeWhere((todo) => todo.id == id);
          if (favTasks.isNotEmpty) {
            favTasks.removeWhere((todo) => todo.id == id);
          }
          if (completeTasks.isNotEmpty) {
            completeTasks.removeWhere((todo) => todo.id == id);
          }
          if (unCompleteTasks.isNotEmpty) {
            unCompleteTasks.removeWhere((todo) => todo.id == id);
          }
          emit(DeleteTheTaskSuccess());
        },
      );
    });
  }

  void changeDay(int currentIndex) async {
    selectedIndex = currentIndex;
    emit(ChangeCurrentSelectedDayState());
  }
}
