import 'dart:convert';

import 'package:app/src/features/login/data/models/login_post_data.dart';
import 'package:app/src/features/login/data/models/login_response.dart';
import 'package:app/src/features/register/data/models/register_post_data.dart';
import 'package:app/src/features/register/data/models/register_response.dart';
import 'package:dio/dio.dart';

abstract class RegisterDataSouce {
  Future<RegisterResponse> register(RegisterPostData loginPostData);
}

class RegisterDataSouceImpl implements RegisterDataSouce {
  @override
  Future<RegisterResponse> register(RegisterPostData loginPostData) async {
    //dio post
    try {
      var dio = Dio();
      var response = await dio.post(
        "http://localhost:8000/api/v1/register",
        data: loginPostData.toJson(),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      RegisterResponse loginResponse = RegisterResponse.fromJson(response.data);

      loginResponse = loginResponse.copyWith(
        statusCode: response.statusCode,
      );

      return loginResponse;
    } catch (e) {
      print(e);
      if (e is DioError) {
        //check if response not null
        if (e.response != null) {
          //check if response data not null
          if (e.response!.data != null) {
            //check if response data has message
            if (e.response!.data['message'] != null) {
              if (e.response!.data['errors'] != null) {
                var errorList = e.response!.data['errors'] as List;
                var result = RegisterResponse(
                  statusCode: e.response!.statusCode,
                  message: e.response!.data['message'],
                  errors: errorList
                      .map((item) => ErrorItem.fromJson(item))
                      .toList(),
                );
                return result;
              } else {
                var result = RegisterResponse(
                  statusCode: e.response!.statusCode,
                  message: e.response!.data['message'],
                );
                return result;
              }
            }
          }
        }

        RegisterResponse loginResponse = RegisterResponse(
          statusCode: 500,
          message: "Unknown Error",
        );
        return loginResponse;
      } else {
        return RegisterResponse(
          statusCode: 500,
          message: e.toString(),
        );
      }
    }
  }
}
