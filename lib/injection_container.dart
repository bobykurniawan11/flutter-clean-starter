import 'package:app/src/core/data/datasources/token_data_source.dart';
import 'package:app/src/core/data/repositories/authentication_repository_impl.dart';
import 'package:app/src/core/domain/repositories/authentication_repository.dart';
import 'package:app/src/core/domain/usecases/check_has_token_usecase.dart';
import 'package:app/src/core/domain/usecases/save_token_usecase.dart';
import 'package:app/src/features/register/domain/repository/register_repository.dart';
import 'package:app/src/features/register/domain/usecase/register_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/core/domain/usecases/delete_token_usecase.dart';
import 'src/core/domain/usecases/get_token_usecase.dart';
import 'src/features/login/data/datasources/login_source.dart';
import 'src/features/login/data/repository/login_repository_impl.dart';
import 'src/features/login/domain/repository/login_repository.dart';
import 'src/features/login/domain/usecase/login_usecase.dart';
import 'src/features/profile/data/datasource/profile_datasource.dart';
import 'src/features/profile/data/repository/profile_repository_impl.dart';
import 'src/features/profile/domain/repository/profile_repository.dart';
import 'src/features/profile/domain/usecase/get_user_usecase.dart';
import 'src/features/register/data/datasources/register_data_source.dart';
import 'src/features/register/data/repository/register_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //usecase

  //authentication
  sl.registerLazySingleton(() => CheckHasTokenUseCase(sl()));
  sl.registerLazySingleton(() => SaveTokenUsecase(sl()));
  sl.registerLazySingleton(() => GetTokenUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTokenUseCase(sl()));

  //login
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  //register
  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  //profile
  sl.registerLazySingleton(() => GetUserUseCase(sl()));

  //repository

  //authentication
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      dataSource: sl(),
    ),
  );
  //login
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      dataSource: sl(),
    ),
  );

  sl.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(
      dataSource: sl(),
    ),
  );
  //profile
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      dataSource: sl(),
    ),
  );

  //data source

  //authentication
  sl.registerLazySingleton<TokenDataSource>(
    () => TokenDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  //login
  sl.registerLazySingleton<LoginDataSouce>(
    () => LoginDataSouceImpl(),
  );

  //register
  sl.registerLazySingleton<RegisterDataSouce>(
    () => RegisterDataSouceImpl(),
  );

  //profile
  sl.registerLazySingleton<ProfileDataSource>(
    () => ProfileDataSourceImpl(),
  );

  //external

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
