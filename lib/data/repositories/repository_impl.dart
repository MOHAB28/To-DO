import 'package:dartz/dartz.dart';
import '../../core/error/exception.dart';
import '../../domain/entities/todo_entity.dart';
import '../../core/error/faliure.dart';
import '../../domain/repositories/repository.dart';
import '../datasources/local_data_sources.dart';

class RepositoryImpl implements Repository {
  final LocalDataSources _dataSources;
  RepositoryImpl(this._dataSources);

  @override
  Future<Either<Failure, void>> addTask(TodoInput todo) async {
    try {
      final localTasks = await _dataSources.addTask(todo);
      return Right(localTasks);
    } on CacheException {
      throw Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> editTask(TodoInput todo) async {
    try {
      final localTasks = await _dataSources.editTask(todo);
      return Right(localTasks);
    } on CacheException {
      throw Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getAllTasks() async {
    try {
      final localTasks = await _dataSources.getAllTasks();
      return Right(localTasks);
    } on CacheException {
      throw Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getCompletedTasks() async {
    try {
      final localTasks = await _dataSources.getCompletedTasks();
      return Right(localTasks);
    } on CacheException {
      throw Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getUnCompletedTasks() async {
    try {
      final localTasks = await _dataSources.getUnCompletedTasks();
      return Right(localTasks);
    } on CacheException {
      throw Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getFavoriteTasks() async {
    try {
      final localTasks = await _dataSources.getFavoriteTasks();
      return Right(localTasks);
    } on CacheException {
      throw Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getTasksBySpecificDate(
    String time,
  ) async {
    try {
      final localTasks = await _dataSources.getTasksBySpecificDate(time);
      return Right(localTasks);
    } on CacheException {
      throw Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> searchInTasks(String title) async {
    try {
      final localTasks = await _dataSources.searchInTasks(title);
      return Right(localTasks);
    } on CacheException {
      throw Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> completeTask(CompleteTasInput input) async {
    try {
      final localTasks = await _dataSources.completeTask(input.id,input.isComplete);
      return Right(localTasks);
    } on CacheException {
      throw Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addToFav(AddToFavInput input) async {
    try {
      final localTasks = await _dataSources.addToFav(input.id,input.isFav);
      return Right(localTasks);
    } on CacheException {
      throw Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(int id) async {
    try {
      final localTasks = await _dataSources.deleteTask(id);
      return Right(localTasks);
    } on CacheException {
      throw Left(CacheFailure());
    }
  }
}
