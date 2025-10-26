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
