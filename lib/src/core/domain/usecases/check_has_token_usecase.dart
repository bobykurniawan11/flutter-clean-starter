import 'package:app/src/core/domain/repositories/authentication_repository.dart';
import 'package:app/src/core/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../error/failures.dart';

class CheckHasTokenUseCase implements UseCase<bool, NoParams> {
  final AuthenticationRepository repository;
  CheckHasTokenUseCase(this.repository);
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    try {
      return await repository.hasToken()!;
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
