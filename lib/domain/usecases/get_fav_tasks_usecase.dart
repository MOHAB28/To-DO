import 'package:dartz/dartz.dart';
import '../../core/error/faliure.dart';
import '../../core/usecase/usecase.dart';
import '../entities/todo_entity.dart';
import '../repositories/repository.dart';

class GetFavoriteTasksUsecase extends UseCase<List<TodoEntity>, NoParams> {
  final Repository _repository;
  GetFavoriteTasksUsecase(this._repository);
  @override
  Future<Either<Failure, List<TodoEntity>>> call(NoParams params) async {
    return await _repository.getFavoriteTasks();
  }
}
