import 'package:app/src/core/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../error/failures.dart';
import '../repositories/authentication_repository.dart';

class DeleteTokenUseCase implements UseCase<bool, NoParams> {
  final AuthenticationRepository repository;
  DeleteTokenUseCase(this.repository);
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.deleteToken();
  }
}
