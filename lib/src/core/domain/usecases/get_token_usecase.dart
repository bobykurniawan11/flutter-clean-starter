import 'package:app/src/core/domain/repositories/authentication_repository.dart';
import 'package:app/src/core/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../error/failures.dart';

class GetTokenUseCase implements UseCase<String, NoParams> {
  final AuthenticationRepository repository;
  GetTokenUseCase(this.repository);
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await repository.getToken();
  }
}
