import 'package:app/src/features/profile/data/models/profile_model.dart';
import 'package:app/src/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/error/failures.dart';

class GetUserUseCase implements UseCase<ProfileModel, String> {
  final ProfileRepository repository;
  GetUserUseCase(this.repository);
  @override
  Future<Either<Failure, ProfileModel>> call(String params) async {
    return await repository.getUser(params);
  }
}
