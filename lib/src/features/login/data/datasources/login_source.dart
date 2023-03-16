import 'package:app/src/features/login/data/models/login_post_data.dart';
import 'package:app/src/features/login/data/models/login_response.dart';
import 'package:dio/dio.dart';

abstract class LoginDataSouce {
  Future<LoginResponse> login(LoginPostData loginPostData);
}

class LoginDataSouceImpl implements LoginDataSouce {
  @override
  Future<LoginResponse> login(LoginPostData loginPostData) async {
    //dio post
    try {
      var dio = Dio();
      var response = await dio.post(
        "http://localhost:8000/api/v1/login",
        data: loginPostData.toJson(),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      LoginResponse loginResponse = LoginResponse.fromJson(response.data);

      loginResponse = loginResponse.copyWith(
        statusCode: response.statusCode,
      );

      return loginResponse;
    } catch (e) {
      if (e is DioError) {
        //check if response not null
        if (e.response != null) {
          //check if response data not null
          if (e.response!.data != null) {
            //check if response data has message
            if (e.response!.data['message'] != null) {
              return LoginResponse(
                statusCode: e.response!.statusCode,
                message: e.response!.data['message'],
              );
            }
          }
        }

        LoginResponse loginResponse = LoginResponse(
          statusCode: 500,
          message: "Unknown Error",
        );
        return loginResponse;
      } else {
        return LoginResponse(
          statusCode: 500,
          message: e.toString(),
        );
      }
    }
  }
}
