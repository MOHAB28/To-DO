import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/models/todo_model.dart';
import '../../domain/repositories/repository.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;

  DbHelper.internal();
  static Database? _db;

  Future<Database> createDatabase() async {
    if (_db != null) {
      return _db!;
    }
    //define the path to the database
    String path = join(await getDatabasesPath(), 'todo.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int v) {
        //create tables
        db
            .execute(
              '''CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT,
           title STRING, 
           isCompleted INTEGER,
            isFav INTEGER,
             date STRING,
             color INTEGER,
             notificationId INTEGER,
              startTime STRING,
               endTime STRING,
                 repeat STRING,
                  remind INTEGER)''',
            )
            .then((value) => debugPrint('database created'))
            .catchError((error) {
              debugPrint('database error => ${error.toString()}');
            });
      },
    );
    return _db!;
  }

  Future<void> createTask(TodoInput todo) async {
    final TodoModel model = TodoModel(
      notificationId: todo.notificationId,
      date: todo.date,
      color: todo.color,
      endTime: todo.endTime,
      isCompleted: todo.isCompleted,
      isFav: todo.isFav,
      remind: todo.remind,
      repeat: todo.repeat,
      startTime: todo.startTime,
      title: todo.title,
    );
    Database db = await createDatabase();
    await db.insert('tasks', model.toJson());
  }

  Future<void> taskUpdate(TodoInput todo) async {
    final TodoModel model = TodoModel(
      date: todo.date,
      endTime: todo.endTime,
      notificationId: todo.notificationId,
      color: todo.color,
      isCompleted: todo.isCompleted,
      isFav: todo.isFav,
      remind: todo.remind,
      repeat: todo.repeat,
      startTime: todo.startTime,
      title: todo.title,
    );
    Database db = await createDatabase();
    await db.update(
      'tasks',
      model.toJson(),
      where: 'notificationId = ?',
      whereArgs: [model.notificationId],
    );
  }

  Future<List<Map<String, dynamic>>> allTasks() async {
    Database db = await createDatabase();
    return await db.rawQuery('SELECT * FROM tasks ORDER BY date');
  }

  Future<List<Map<String, dynamic>>> completedTasks(int isCompleted) async {
    Database db = await createDatabase();
    return await db.query(
      'tasks',
      where: 'isCompleted = ?',
      whereArgs: [isCompleted],
    );
  }

  Future<List<Map<String, dynamic>>> favoriteTasks(int isFav) async {
    Database db = await createDatabase();
    return await db.query(
      'tasks',
      where: 'isFav = ?',
      whereArgs: [isFav],
    );
  }

  Future<List<Map<String, dynamic>>> specificTimeTasks(String date) async {
    Database db = await createDatabase();
    return await db.query(
      'tasks',
      where: 'date = ?',
      whereArgs: [date],
    );
  }

  Future<List<Map<String, dynamic>>> searchInTask(String title) async {
    Database db = await createDatabase();
    return await db.rawQuery(
      "SELECT * FROM tasks WHERE title LIKE '%${title.isEmpty? '____' : title}%';",
    );
  }

  Future<void> makeTaskCompleted(int id, int complete) async {
    Database db = await createDatabase();
    await db.update(
      'tasks',
      {'isCompleted': complete},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> favTheTask(int id, int fav) async {
    Database db = await createDatabase();
    await db.update(
      'tasks',
      {'isFav': fav},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> delete(int id) async {
    Database db = await createDatabase();

    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
