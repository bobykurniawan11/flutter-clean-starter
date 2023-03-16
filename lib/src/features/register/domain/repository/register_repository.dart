import 'package:app/src/features/login/data/models/login_response.dart';
import 'package:app/src/features/register/data/models/register_response.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/register_post_data.dart';

abstract class RegisterRepository {
  Future<Either<Failure, RegisterResponse>> register(RegisterPostData params);
}
