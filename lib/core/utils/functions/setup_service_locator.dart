import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../features/auth/data/data_source/auth_remote_data_source.dart';
import '../../../features/auth/data/repos_impl/auth_repo_impl.dart';
import '../../../features/auth/domain/repos/auth_repo.dart';
import '../../../features/auth/domain/use_cases/login_use_case.dart';
import '../../../features/auth/domain/use_cases/register_use_case.dart';
import '../../../features/auth/presentation/manager/login_api/login_api_cubit.dart';
import '../../../features/auth/presentation/manager/register_api/register_api_cubit.dart';
import '../api_service.dart';
import '../network/network_request.dart';

final getIt = GetIt.instance;
Future<void> init() async {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  //Network
  getIt.registerLazySingleton<NetworkRequest>(() => NetworkRequestImp());

  // Register
  getIt.registerFactory<RegisterApiCubit>(() => RegisterApiCubit(getIt.call()));
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<RegisterRepo>(
    () => RegisterRepoImpl(getIt.call()),
  );
  getIt.registerLazySingleton<RegisterRemoteDataSource>(
    () => RegisterRemoteDataSourceImpl(),
  );
  // Login
  getIt.registerFactory<LoginApiCubit>(() => LoginApiCubit(getIt.call()));
  getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt.call()));
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepoImpl(getIt.call()));
  getIt.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(),
  );
}
