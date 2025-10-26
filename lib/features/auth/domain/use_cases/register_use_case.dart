import 'dart:io';

import '../../data/data_source/auth_remote_data_source.dart';
import '../../data/models/register_model/register_model.dart';
import '../repos/auth_repo.dart';

abstract class UseCase<type> {
  Future<RegisterResponse> call({
    required String email,
    required String userName,
    required String password,
    required String confirmPassword,
    required File image,
  });
}

class RegisterUseCase extends UseCase<RegisterModel> {
  final RegisterRepo registerRepo;
  RegisterUseCase(this.registerRepo);

  @override
  Future<RegisterResponse> call({
    required String email,
    required String userName,
    required String password,
    required String confirmPassword,
    required File image,
  }) async {
    return await registerRepo.register(
      confirmPassword: confirmPassword,
      email: email,
      image: image,
      password: password,
      userName: userName,
    );
  }
}
