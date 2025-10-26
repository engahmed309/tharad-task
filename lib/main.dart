import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/utils/constants.dart';
import 'core/utils/functions/setup_service_locator.dart' as di;
import 'core/utils/simple_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  // Hive.registerAdapter(CurrentUserEntityAdapter());
  // await Hive.openBox<CurrentUserEntity>(kCurrentUserBox);
  await Hive.openBox(kAccessTokenBox);

  await di.init();
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(const TharadApp());
}
