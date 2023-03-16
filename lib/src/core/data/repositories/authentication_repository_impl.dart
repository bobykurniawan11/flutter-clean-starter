import 'package:dartz/dartz.dart';

import '../../domain/repositories/authentication_repository.dart';
import '../../error/exceptions.dart';
import '../../error/failures.dart';
import '../datasources/token_data_source.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final TokenDataSource dataSource;

  AuthenticationRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, bool>> hasToken() async {
    try {
      final hasTokenCheck = await dataSource.hasToken();
      return Right(hasTokenCheck);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveToken(String token) async {
    try {
      final _setToken = await dataSource.saveToken(token);
      return Right(_setToken);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getToken() async {
    try {
      final _getToken = await dataSource.getToken();
      return Right(_getToken);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteToken() async {
    try {
      final _deleteToken = await dataSource.deleteToken();
      return Right(_deleteToken);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
