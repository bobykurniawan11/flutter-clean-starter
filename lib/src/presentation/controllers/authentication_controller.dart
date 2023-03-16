import 'package:app/src/core/domain/usecases/save_token_usecase.dart';
import 'package:app/src/core/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../core/domain/usecases/check_has_token_usecase.dart';
import '../../core/domain/usecases/get_token_usecase.dart';
import '../../core/error/failures.dart';

class AuthenticationController extends GetxController {
  //CheckHasTokenUseCase
  late CheckHasTokenUseCase checkHasTokenUseCase;
  late SaveTokenUsecase saveTokenUsecase;
  late GetTokenUseCase getTokenUseCase;
  @override
  void onInit() {
    checkHasTokenUseCase = GetIt.I<CheckHasTokenUseCase>();
    saveTokenUsecase = GetIt.I<SaveTokenUsecase>();
    getTokenUseCase = GetIt.I<GetTokenUseCase>();
    super.onInit();
  }

  checkToken() async {
    Either<Failure, bool> _getToken =
        await checkHasTokenUseCase.call(NoParams());

    return _getToken;
  }

  saveToken() async {
    await saveTokenUsecase.call("TESTINGG TOKEN 2222");
  }

  getToken() async {
    Either<Failure, String> _getToken = await getTokenUseCase.call(NoParams());
    return _getToken;
  }
}
