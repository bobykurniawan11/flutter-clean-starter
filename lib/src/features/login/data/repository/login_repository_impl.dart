import 'package:app/src/features/login/data/datasources/login_source.dart';
import 'package:app/src/features/login/data/models/login_response.dart';
import 'package:app/src/features/login/data/models/login_post_data.dart';
import 'package:app/src/core/error/failures.dart';
import 'package:app/src/features/login/domain/repository/login_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSouce dataSource;
  LoginRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, LoginResponse>> login(LoginPostData params) async {
    try {
      final hasTokenCheck = await dataSource.login(params);
      return Right(hasTokenCheck);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
