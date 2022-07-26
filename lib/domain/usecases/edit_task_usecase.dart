import 'package:dartz/dartz.dart';
import '../../core/error/faliure.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/repository.dart';

class EditTaskUsecase extends UseCase<void, TodoUsecaseInput> {
  final Repository _repository;
  EditTaskUsecase(this._repository);
  @override
  Future<Either<Failure, void>> call(TodoUsecaseInput params) async {
    return await _repository.editTask(
      TodoInput(
        date: params.date,
        notificationId: params.notificationId,
        color: params.color,
        endTime: params.endTime,
        isFav: params.isFav,
        isCompleted: params.isCompleted,
        remind: params.remind,
        repeat: params.repeat,
        startTime: params.startTime,
        title: params.title,
      ),
    );
  }
}
