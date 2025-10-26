import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tharad_tech_task/features/auth/presentation/manager/verify_otp_api/verify_otp_api_cubit.dart';
import 'package:tharad_tech_task/features/profile/presentation/manager/profile_details/profile_details_cubit.dart';

import '../../../features/auth/data/data_source/auth_remote_data_source.dart';
import '../../../features/auth/data/repos_impl/auth_repo_impl.dart';
import '../../../features/auth/domain/repos/auth_repo.dart';
import '../../../features/auth/domain/use_cases/login_use_case.dart';
import '../../../features/auth/domain/use_cases/otp_use_case.dart';
import '../../../features/auth/domain/use_cases/register_use_case.dart';
import '../../../features/auth/presentation/manager/login_api/login_api_cubit.dart';
import '../../../features/auth/presentation/manager/register_api/register_api_cubit.dart';
import '../../../features/profile/data/data_source/profile_remote_data_source.dart';
import '../../../features/profile/data/repo_impl/profile_repo_impl.dart';
import '../../../features/profile/domain/repos/profile_repo.dart';
import '../../../features/profile/domain/use_cases/profile_use_case.dart';
import '../../../features/profile/domain/use_cases/update_propfile_use_case.dart';
import '../../../features/profile/presentation/manager/update_profile/update_profile_cubit.dart';
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

  // Otp

  getIt.registerFactory<VerifyOtpApiCubit>(
    () => VerifyOtpApiCubit(getIt.call()),
  );
  getIt.registerLazySingleton<OtpUseCase>(() => OtpUseCase(getIt.call()));
  getIt.registerLazySingleton<OtpRepo>(() => OtpRepoImpl(getIt.call()));
  getIt.registerLazySingleton<OtpRemoteDataSource>(
    () => OtpRemoteDataSourceImpl(),
  );

  // Profile Details

  getIt.registerFactory<ProfileDetailsCubit>(
    () => ProfileDetailsCubit(getIt.call()),
  );
  getIt.registerLazySingleton<ProfileUseCase>(
    () => ProfileUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl(getIt.call()));
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(),
  );

  // Update Profile Details

  getIt.registerFactory<UpdateProfileCubit>(
    () => UpdateProfileCubit(getIt.call()),
  );
  getIt.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<UpdateProfileRepo>(
    () => UpdateProfileRepoImpl(getIt.call()),
  );
  getIt.registerLazySingleton<UpdateProfileRemoteDataSource>(
    () => UpdateProfileRemoteDataSourceImpl(),
  );
}
