// Register
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../../core/utils/functions/setup_service_locator.dart';
import '../../../../../../core/utils/network/api/network_api.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';
import '../models/login_model/login_model.dart';
import '../models/otp_model.dart';
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
// Login remote Data source

typedef LoginResponse = Either<String, LoginModel>;

abstract class LoginRemoteDataSource {
  Future<LoginResponse> login({
    required String email,
    required String password,
  });
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    LoginResponse loginResponse = left("");

    try {
      final formData = FormData.fromMap({"email": email, "password": password});

      await getIt<NetworkRequest>().requestFutureData<LoginModel>(
        Method.post,
        url: Api.login,
        formData: formData,
        isFormData: true,
        options: Options(contentType: 'multipart/form-data'),
        onSuccess: (data) {
          if (data.status == "success") {
            loginResponse = right(data);
          } else {
            loginResponse = left(data.message ?? 'Unknown error');
          }
        },
        onError: (code, msg) {
          if (code == 403) {
            loginResponse = left(
              "$code Please verify your OTP before logging in.",
            );
          } else if (code == 401) {
            loginResponse = left("$code Login failed. Invalid credentials.");
          } else {
            loginResponse = left("$msg ($code)");
          }
        },
      );
    } catch (e) {
      loginResponse = left("Unexpected error: $e");
    }

    return loginResponse;
  }
}

// otp
typedef OtpResponse = Either<String, SimpleModel>;

abstract class OtpRemoteDataSource {
  Future<OtpResponse> verifyOtp({required String email, required String otp});
}

class OtpRemoteDataSourceImpl extends OtpRemoteDataSource {
  @override
  Future<OtpResponse> verifyOtp({
    required String email,
    required String otp,
  }) async {
    OtpResponse otpResponse = left("");

    try {
      final params = {"email": email, "otp": otp};

      await getIt<NetworkRequest>().requestFutureData<SimpleModel>(
        Method.get,
        url: Api.otp,
        queryParams: params,
        options: Options(contentType: 'application/json'),
        onSuccess: (data) {
          otpResponse = right(data);
        },
        onError: (code, msg) {
          if (code == 400) {
            otpResponse = left("$code Invalid OTP");
          } else {
            otpResponse = left("$msg ($code)");
          }
        },
      );
    } catch (e) {
      otpResponse = left("Unexpected error: $e");
    }

    return otpResponse;
  }
}
