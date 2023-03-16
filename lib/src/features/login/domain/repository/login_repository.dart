import 'package:app/src/features/login/data/models/login_response.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/login_post_data.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginResponse>> login(LoginPostData params);
}
