// Register
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../../core/utils/functions/setup_service_locator.dart';
import '../../../../../../core/utils/network/api/network_api.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';
import '../models/register_model/register_model.dart';

typedef RegisterResponse = Either<String, RegisterModel>;

abstract class RegisterRemoteDataSource {
  Future<RegisterResponse> register({
    required String email,
    required String userName,
    required String password,
    required String confirmPassword,
    required File image,
  });
}

class RegisterRemoteDataSourceImpl extends RegisterRemoteDataSource {
  @override
  Future<RegisterResponse> register({
    required String email,
    required String userName,
    required String password,
    required String confirmPassword,
    required File image,
  }) async {
    RegisterResponse registerResponse = left("");

    try {
      final formData = FormData.fromMap({
        "email": email,
        "username": userName,
        "password": password,
        "password_confirmation": confirmPassword,
        "image": await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      await getIt<NetworkRequest>().requestFutureData<RegisterModel>(
        Method.post,
        url: Api.register,
        formData: formData,
        isFormData: true,
        options: Options(contentType: 'multipart/form-data'),
        onSuccess: (data) {
          if (data.status == "success") {
            registerResponse = right(data);
          } else {
            registerResponse = left(data.message ?? 'Unknown error');
          }
        },
        onError: (code, msg) {
          registerResponse = left("$msg ($code)");
        },
      );
    } catch (e) {
      registerResponse = left("Unexpected error: $e");
    }

    return registerResponse;
  }
}
