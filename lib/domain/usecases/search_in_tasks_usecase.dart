import 'package:dartz/dartz.dart';
import '../../core/error/faliure.dart';
import '../../core/usecase/usecase.dart';
import '../entities/todo_entity.dart';
import '../repositories/repository.dart';

class SearchInTasksUsecase extends UseCase<List<TodoEntity>, String> {
  final Repository _repository;
  SearchInTasksUsecase(this._repository);
  @override
  Future<Either<Failure, List<TodoEntity>>> call(String params) async {
    return await _repository.searchInTasks(params);
  }
}
