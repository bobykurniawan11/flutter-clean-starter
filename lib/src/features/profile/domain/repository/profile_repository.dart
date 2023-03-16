import 'package:app/src/features/login/data/models/login_response.dart';
import 'package:app/src/features/profile/data/models/profile_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileModel>> getUser(String params);
}
