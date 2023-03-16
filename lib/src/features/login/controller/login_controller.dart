//login controller

import 'package:app/src/core/domain/usecases/check_has_token_usecase.dart';
import 'package:app/src/core/domain/usecases/delete_token_usecase.dart';
import 'package:app/src/core/domain/usecases/save_token_usecase.dart';
import 'package:app/src/core/domain/usecases/usecase.dart';
import 'package:app/src/features/login/data/models/login_post_data.dart';
import 'package:app/src/features/login/domain/usecase/login_usecase.dart';
import 'package:app/src/features/profile/domain/usecase/get_user_usecase.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../core/domain/usecases/get_token_usecase.dart';
import '../data/models/login_response.dart';

class LoginController extends GetxController {
  late LoginUseCase loginUseCase;
  late SaveTokenUsecase saveTokenUsecase;
  late CheckHasTokenUseCase checkHasTokenUseCase;
  late GetTokenUseCase getTokenUseCase;
  late DeleteTokenUseCase deleteTokenUseCase;
  late GetUserUseCase getUserUseCase;
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  Rx<LoginResponse> loginResponse = LoginResponse().obs;

  @override
  void onInit() {
    loginUseCase = GetIt.I<LoginUseCase>();
    saveTokenUsecase = GetIt.I<SaveTokenUsecase>();
    checkHasTokenUseCase = GetIt.I<CheckHasTokenUseCase>();
    getTokenUseCase = GetIt.I<GetTokenUseCase>();
    deleteTokenUseCase = GetIt.I<DeleteTokenUseCase>();
    getUserUseCase = GetIt.I<GetUserUseCase>();
    checkHasToken();
    super.onInit();
  }

  checkHasToken() {
    checkHasTokenUseCase.call(NoParams()).then((value) {
      value.fold((failure) async {
        await deleteTokenUseCase.call(NoParams());
      }, (success) async {
        if (success) {
          await getTokenUseCase.call(NoParams()).then((value) {
            value.fold((failure) async {
              await deleteTokenUseCase.call(NoParams());
            }, (success) {
              validateToken(success);
            });
          });
        }
      });
    });
  }

  validateToken(String token) async {
    await getTokenUseCase(NoParams()).then((value) {
      value.fold((failure) async {
        await deleteTokenUseCase.call(NoParams());
      }, (success) async {
        await getUserUseCase.call(token).then((value) {
          value.fold((failure) async {
            await deleteTokenUseCase.call(NoParams());
            print("Failed to get user");
          }, (success) {
            print("Success to get user");
            print(success);
            Get.offAllNamed('/dashboard');
          });
        });
      });
    });
  }

  Future<void> login(LoginPostData params) async {
    //reset loginResponse
    loginResponse.value = LoginResponse();

    if (isLoading.isTrue) return;
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2));
    final result = await loginUseCase(params);
    isLoading.value = false;
    result.fold(
      (failure) {
        isError.value = true;
        update();
      },
      (success) async {
        loginResponse.value = success;

        if (loginResponse.value.statusCode != 200) {
          //update statuscode from loginResponse to 500
          loginResponse.value = loginResponse.value.copyWith(statusCode: 500);
          isError.value = true;
        } else {
          isError.value = false;
          await saveTokenUsecase(loginResponse.value.accessToken!);
          Get.offAllNamed('/dashboard');
        }
      },
    );
    isLoading.value = false;
    update();
  }
}
