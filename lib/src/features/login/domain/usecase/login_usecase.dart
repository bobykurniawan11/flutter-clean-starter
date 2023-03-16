import 'package:app/src/features/login/data/models/login_post_data.dart';
import 'package:app/src/features/login/domain/repository/login_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/login_response.dart';

class LoginUseCase implements UseCase<LoginResponse, LoginPostData> {
  final LoginRepository repository;
  LoginUseCase(this.repository);
  @override
  Future<Either<Failure, LoginResponse>> call(LoginPostData params) async {
    return await repository.login(params);
  }
}
