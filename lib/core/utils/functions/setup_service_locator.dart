import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../api_service.dart';
import '../network/network_request.dart';

final getIt = GetIt.instance;
Future<void> init() async {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  //Network
  getIt.registerLazySingleton<NetworkRequest>(() => NetworkRequestImp());
}
