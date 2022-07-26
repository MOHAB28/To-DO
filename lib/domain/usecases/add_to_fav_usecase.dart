import 'package:dartz/dartz.dart';
import '../../core/error/faliure.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/repository.dart';

class AddToFavUsecase extends UseCase<void, AddToFavUsecaseInput> {
  final Repository _repository;
  AddToFavUsecase(this._repository);
  @override
  Future<Either<Failure, void>> call(AddToFavUsecaseInput params) async {
    return await _repository.addToFav(AddToFavInput(params.id, params.isFav));
  }
}

class AddToFavUsecaseInput {
  final int id;
  final int isFav;
  AddToFavUsecaseInput(this.id, this.isFav);
}
