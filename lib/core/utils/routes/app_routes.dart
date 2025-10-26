import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad_tech_task/features/auth/presentation/views/otp_view.dart';

import '../../../features/auth/presentation/manager/login_form/login_form_cubit.dart';
import '../../../features/auth/presentation/manager/otp_cubit/otp_cubit.dart';
import '../../../features/auth/presentation/manager/register_form/register_form_cubit.dart';
import '../../../features/auth/presentation/views/login_view.dart';
import '../../../features/auth/presentation/views/register_view.dart';
import '../constants.dart';

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case initialRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RegisterFormCubit(),
            child: const RegisterView(),
          ),
        );

      case loginRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginFormCubit(),
            child: const LoginView(),
          ),
        );
      case otpRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OtpCubit()..startTimer(),
            child: const OtpView(),
          ),
        );
      default:
        return null;
    }
  }
}
