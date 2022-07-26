import 'package:dartz/dartz.dart';
import '../../core/error/faliure.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/repository.dart';

class CompleteTaskUsecase extends UseCase<void, CompleteTasUseCaseInput> {
  final Repository _repository;
  CompleteTaskUsecase(this._repository);
  @override
  Future<Either<Failure, void>> call(CompleteTasUseCaseInput params) async {
    return await _repository.completeTask(CompleteTasInput(params.id,params.isComplete));
  }
}

class CompleteTasUseCaseInput {
  final int id;
  final int isComplete;
  CompleteTasUseCaseInput(this.id,this.isComplete);
}