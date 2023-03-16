import 'package:app/src/features/register/data/datasources/register_data_source.dart';
import 'package:app/src/features/register/data/models/register_post_data.dart';
import 'package:app/src/features/register/data/models/register_response.dart';
import 'package:app/src/features/register/domain/repository/register_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterDataSouce dataSource;
  RegisterRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, RegisterResponse>> register(
      RegisterPostData params) async {
    try {
      final hasTokenCheck = await dataSource.register(params);
      return Right(hasTokenCheck);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
