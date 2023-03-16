import 'package:app/src/core/domain/repositories/authentication_repository.dart';
import 'package:app/src/core/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../error/failures.dart';

class SaveTokenUsecase implements UseCase<bool, String> {
  final AuthenticationRepository repository;
  SaveTokenUsecase(this.repository);
  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await repository.saveToken(params);
  }
}
