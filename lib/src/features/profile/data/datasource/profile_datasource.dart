import 'package:app/src/features/profile/data/models/profile_model.dart';
import 'package:dio/dio.dart';

abstract class ProfileDataSource {
  Future<ProfileModel> getUser(String token);
}

//implement
class ProfileDataSourceImpl implements ProfileDataSource {
  @override
  Future<ProfileModel> getUser(String token) async {
    try {
      var dio = Dio();
      var response = await dio.get(
        "http://localhost:8000/api/v1/me",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      ProfileModel profileData = ProfileModel.fromJson(response.data);

      return profileData;
    } catch (e) {
      print(e);
      if (e is DioError) {
        //check if response not null
        if (e.response != null) {
          //check if response data not null
          if (e.response!.data != null) {
            //check if response data has message
            if (e.response!.data['message'] != null) {
              throw Exception(e.response!.data['message']);
            }
          }
        }

        throw Exception("Unknown Error");
      } else {
        throw Exception(e.toString());
      }
    }
  }
}
