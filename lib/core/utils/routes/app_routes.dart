import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/auth/presentation/manager/register_form/register_form_cubit.dart';
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

      default:
        return null;
    }
  }
}
