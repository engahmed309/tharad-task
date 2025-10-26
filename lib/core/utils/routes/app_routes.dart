import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad_tech_task/features/auth/presentation/manager/login_api/login_api_cubit.dart';
import 'package:tharad_tech_task/features/auth/presentation/views/otp_view.dart';

import '../../../features/auth/presentation/manager/login_form/login_form_cubit.dart';
import '../../../features/auth/presentation/manager/otp_timer_cubit/otp_timer_cubit.dart';
import '../../../features/auth/presentation/manager/register_api/register_api_cubit.dart';
import '../../../features/auth/presentation/manager/register_form/register_form_cubit.dart';
import '../../../features/auth/presentation/manager/verify_otp_api/verify_otp_api_cubit.dart';
import '../../../features/auth/presentation/views/login_view.dart';
import '../../../features/auth/presentation/views/register_view.dart';
import '../constants.dart';
import '../functions/setup_service_locator.dart';

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case initialRoute:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => RegisterFormCubit()),
              BlocProvider(create: (context) => getIt<RegisterApiCubit>()),
            ],
            child: const RegisterView(),
          ),
        );

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
      default:
        return null;
    }
  }
}
