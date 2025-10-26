import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tharad_tech_task/core/utils/assets.dart';

import '../../../features/profile/domain/entity/user_data_entity.dart';
import '../constants.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  Future<void> _navigate(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    final userBox = Hive.box<UserDataEntity>(kUserDataBox);
    final hasUser = userBox.get(kUserDataBox) != null;

    if (hasUser) {
      Navigator.pushReplacementNamed(context, profileRoute);
    } else {
      Navigator.pushReplacementNamed(context, registerRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Trigger navigation after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigate(context);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset(AssetsData.logo)),
    );
  }
}
