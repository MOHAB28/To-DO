import '../../core/services/database.dart';
import '../../domain/repositories/repository.dart';
import '../models/todo_model.dart';

abstract class LocalDataSources {
  Future<void> addTask(TodoInput todo);
  Future<List<TodoModel>> getAllTasks();
  Future<List<TodoModel>> getCompletedTasks();
  Future<List<TodoModel>> getUnCompletedTasks();
  Future<List<TodoModel>> getFavoriteTasks();
  Future<List<TodoModel>> searchInTasks(String title);
  Future<List<TodoModel>> getTasksBySpecificDate(String time);
  Future<void> editTask(TodoInput todo);
  Future<void> addToFav(int id,int isFav);
  Future<void> completeTask(int id,int isComplete);
  Future<void> deleteTask(int id);
}

class LocalDataSourcesImpl implements LocalDataSources {
  final DbHelper _dbHelper;
  LocalDataSourcesImpl(this._dbHelper);

  @override
  Future<void> addTask(TodoInput todo) async {
    await _dbHelper.createTask(todo);
  }

  @override
  Future<void> editTask(TodoInput todo) async {
    await _dbHelper.taskUpdate(todo);
  }

  @override
  Future<List<TodoModel>> getAllTasks() async {
    List dBTasks = await _dbHelper.allTasks();
    List<TodoModel> tasks = [];
    for (var task in dBTasks) {
      tasks.add(TodoModel.fromJson(task));
    }
    return tasks;
  }

  @override
  Future<List<TodoModel>> getCompletedTasks() async {
    List dBTasks = await _dbHelper.completedTasks(1);
    List<TodoModel> tasks = [];
    for (var task in dBTasks) {
      tasks.add(TodoModel.fromJson(task));
    }
    return tasks;
  }

  @override
  Future<List<TodoModel>> getUnCompletedTasks() async {
    List dBTasks = await _dbHelper.completedTasks(0);
    List<TodoModel> tasks = [];
    for (var task in dBTasks) {
      tasks.add(TodoModel.fromJson(task));
    }
    return tasks;
  }

  @override
  Future<List<TodoModel>> getFavoriteTasks() async {
    List dBTasks = await _dbHelper.favoriteTasks(1);
    List<TodoModel> tasks = [];
    for (var task in dBTasks) {
      tasks.add(TodoModel.fromJson(task));
    }
    return tasks;
  }

  @override
  Future<List<TodoModel>> getTasksBySpecificDate(String time) async {
    List dBTasks = await _dbHelper.specificTimeTasks(time);
    List<TodoModel> tasks = [];
    for (var task in dBTasks) {
      tasks.add(TodoModel.fromJson(task));
    }
    return tasks;
  }

  @override
  Future<List<TodoModel>> searchInTasks(String title) async {
    List dBTasks = await _dbHelper.searchInTask(title);
    List<TodoModel> tasks = [];
    for (var task in dBTasks) {
      tasks.add(TodoModel.fromJson(task));
    }
    return tasks;
  }

  @override
  Future<void> completeTask(int id,int isComplete) async {
    await _dbHelper.makeTaskCompleted(id, isComplete);
  }

  @override
  Future<void> addToFav(int id, int isFav) async {
    await _dbHelper.favTheTask(id, isFav);
  }

  @override
  Future<void> deleteTask(int id) async {
    await _dbHelper.delete(id);
  }
}
