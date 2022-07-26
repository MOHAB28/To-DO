import 'package:dartz/dartz.dart';
import '../../core/error/faliure.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/repository.dart';

class DeleteTaskUsecase extends UseCase<void, int> {
  final Repository _repository;
  DeleteTaskUsecase(this._repository);
  @override
  Future<Either<Failure, void>> call(int params) async {
    return await _repository.deleteTask(params);
  }
}
