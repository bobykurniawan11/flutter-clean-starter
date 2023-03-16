import 'package:shared_preferences/shared_preferences.dart';

abstract class TokenDataSource {
  Future<bool> hasToken();
  Future<bool> saveToken(String token);
  Future<String> getToken();
  Future<bool> deleteToken();
}

class TokenDataSourceImpl implements TokenDataSource {
  final SharedPreferences sharedPreferences;

  TokenDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> hasToken() async {
    bool hasToken = sharedPreferences.getString('token') == null ? false : true;
    return hasToken;
  }

  @override
  Future<bool> saveToken(String token) async {
    bool hasToken = await sharedPreferences.setString('token', token);
    return hasToken;
  }

  @override
  Future<String> getToken() async {
    String token = sharedPreferences.getString('token') ?? '';
    return token;
  }

  @override
  Future<bool> deleteToken() async {
    bool hasToken = await sharedPreferences.remove('token');
    return hasToken;
  }
}
