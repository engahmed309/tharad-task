// register

import 'dart:io';

import '../../domain/repos/auth_repo.dart';
import '../data_source/auth_remote_data_source.dart';

class RegisterRepoImpl extends RegisterRepo {
  final RegisterRemoteDataSource registerRemoteDataSource;

  RegisterRepoImpl(this.registerRemoteDataSource);

  @override
  Future<RegisterResponse> register({
    required String email,
    required String userName,
    required String password,
    required String confirmPassword,
    required File image,
  }) async {
    var registerData = await registerRemoteDataSource.register(
      email: email,
      userName: userName,
      password: password,
      confirmPassword: confirmPassword,
      image: image,
    );
    return registerData;
  }
}

// Login
class LoginRepoImpl extends LoginRepo {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepoImpl(this.loginRemoteDataSource);

  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    var loginData = await loginRemoteDataSource.login(
      email: email,
      password: password,
    );
    return loginData;
  }
}

// otp repo

class OtpRepoImpl extends OtpRepo {
  final OtpRemoteDataSource otpRemoteDataSource;

  OtpRepoImpl(this.otpRemoteDataSource);

  @override
  Future<OtpResponse> verifyOtp({
    required String email,
    required String otp,
  }) async {
    var otpData = await otpRemoteDataSource.verifyOtp(email: email, otp: otp);
    return otpData;
  }
}
