import 'dart:convert';

import 'package:app/src/features/register/data/models/register_post_data.dart';
import 'package:app/src/features/register/data/models/register_response.dart';
import 'package:app/src/features/register/domain/usecase/register_usecase.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/domain/usecases/save_token_usecase.dart';

class RegisterController extends GetxController {
  late RegisterUseCase usecase;
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  Rx<RegisterResponse> registerResponse = RegisterResponse().obs;
  late SaveTokenUsecase saveTokenUsecase;

  @override
  onInit() {
    usecase = GetIt.I<RegisterUseCase>();
    saveTokenUsecase = GetIt.I<SaveTokenUsecase>();
    super.onInit();
  }

  Future<void> call(RegisterPostData params) async {
    //reset loginResponse
    registerResponse.value = RegisterResponse();
    if (isLoading.isTrue) return;
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2));
    final result = await usecase.call(params);
    isLoading.value = false;
    result.fold(
      (failure) {
        isError.value = true;
        update();
      },
      (success) async {
        registerResponse.value = success;

        if (registerResponse.value.statusCode != 200) {
          //update statuscode from registerResponse to 500
          registerResponse.value =
              registerResponse.value.copyWith(statusCode: 500);
          isError.value = true;
        } else {
          isError.value = false;
          await saveTokenUsecase(registerResponse.value.accessToken!);
          Get.offAllNamed('/dashboard');
        }
      },
    );
    isLoading.value = false;
    update();
  }
}
