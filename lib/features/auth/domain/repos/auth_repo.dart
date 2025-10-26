import 'dart:io';

import '../../data/data_source/auth_remote_data_source.dart';

abstract class RegisterRepo {
  Future<RegisterResponse> register({
    required String email,
    required String userName,
    required String password,
    required String confirmPassword,
    required File image,
  });
}
