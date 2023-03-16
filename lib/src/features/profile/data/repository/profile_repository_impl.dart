import 'package:app/src/core/error/failures.dart';
import 'package:app/src/features/profile/data/datasource/profile_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:app/src/features/profile/data/models/profile_model.dart';

import '../../domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource dataSource;
  ProfileRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, ProfileModel>> getUser(String params) async {
    try {
      return Right(await dataSource.getUser(params));
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
