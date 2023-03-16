import 'package:dartz/dartz.dart';

import '../../error/failures.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, bool>>? hasToken();
  Future<Either<Failure, bool>> saveToken(String token);
  Future<Either<Failure, String>> getToken();
  Future<Either<Failure, bool>> deleteToken();
}
