import 'package:app/src/features/login/data/models/login_post_data.dart';
import 'package:app/src/features/login/domain/repository/login_repository.dart';
import 'package:app/src/features/register/data/models/register_post_data.dart';
import 'package:app/src/features/register/data/models/register_response.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../repository/register_repository.dart';

class RegisterUseCase implements UseCase<RegisterResponse, RegisterPostData> {
  final RegisterRepository repository;
  RegisterUseCase(this.repository);
  @override
  Future<Either<Failure, RegisterResponse>> call(
      RegisterPostData params) async {
    return await repository.register(params);
  }
}
