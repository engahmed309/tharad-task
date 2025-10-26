import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:tharad_tech_task/features/auth/presentation/manager/login_api/login_api_cubit.dart';
import 'package:tharad_tech_task/features/auth/presentation/views/otp_view.dart';
import 'package:tharad_tech_task/features/profile/presentation/views/profile_view.dart';

import '../../../features/auth/presentation/manager/login_form/login_form_cubit.dart';
import '../../../features/auth/presentation/manager/otp_timer_cubit/otp_timer_cubit.dart';
import '../../../features/auth/presentation/manager/register_api/register_api_cubit.dart';
import '../../../features/auth/presentation/manager/register_form/register_form_cubit.dart';
import '../../../features/auth/presentation/manager/verify_otp_api/verify_otp_api_cubit.dart';
import '../../../features/auth/presentation/views/login_view.dart';
import '../../../features/auth/presentation/views/register_view.dart';
import '../../../features/profile/domain/entity/user_data_entity.dart';
import '../../../features/profile/presentation/manager/profile_details/profile_details_cubit.dart';
import '../../../features/profile/presentation/manager/update_profile/update_profile_cubit.dart';
import '../constants.dart';
import '../functions/setup_service_locator.dart';

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case initialRoute:
        final userBox = Hive.box<UserDataEntity>(kUserDataBox);
        final tokenBox = Hive.box(kAccessTokenBox);

        final storedUser = userBox.get(kUserDataBox);
        final token = tokenBox.get(kAccessTokenBox);

        final hasValidUser = storedUser != null && token != null;

        if (hasValidUser) {
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      getIt<ProfileDetailsCubit>()
                        ..getProfileData(token: token),
                ),
                BlocProvider(create: (context) => RegisterFormCubit()),
                BlocProvider(create: (context) => getIt<UpdateProfileCubit>()),
              ],
              child: ProfileView(),
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => RegisterFormCubit()),
                BlocProvider(create: (context) => getIt<RegisterApiCubit>()),
              ],
              child: const RegisterView(),
            ),
          );
        }

      case loginRoute:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => LoginFormCubit()),
              BlocProvider(create: (context) => getIt<LoginApiCubit>()),
            ],
            child: const LoginView(),
          ),
        );

      case otpRoute:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => OtpTimerCubit()..startTimer()),
              BlocProvider(create: (context) => getIt<VerifyOtpApiCubit>()),
            ],
            child: OtpView(email: args as String),
          ),
        );

      case profileRoute:
        final userBox = Hive.box<UserDataEntity>(kUserDataBox);
        final tokenBox = Hive.box(kAccessTokenBox);
        final storedUser = userBox.get(kUserDataBox);
        final token = tokenBox.get(kAccessTokenBox);

        if (storedUser == null || token == null) {
          // لو البيانات ناقصة نرجع للـ login
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => LoginFormCubit()),
                BlocProvider(create: (context) => getIt<LoginApiCubit>()),
              ],
              child: const LoginView(),
            ),
          );
        }

        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<ProfileDetailsCubit>()..getProfileData(token: token),
              ),
              BlocProvider(create: (context) => RegisterFormCubit()),
              BlocProvider(create: (context) => getIt<UpdateProfileCubit>()),
            ],
            child: ProfileView(),
          ),
        );

      default:
        return null;
    }
  }
}
