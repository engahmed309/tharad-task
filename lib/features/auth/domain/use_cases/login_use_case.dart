import '../../data/data_source/auth_remote_data_source.dart';
import '../../data/models/login_model/login_model.dart';
import '../repos/auth_repo.dart';

abstract class UseCase<type> {
  Future<LoginResponse> call({required String email, required String password});
}

class LoginUseCase extends UseCase<LoginModel> {
  final LoginRepo loginRepo;
  LoginUseCase(this.loginRepo);

  @override
  Future<LoginResponse> call({
    required String email,
    required String password,
  }) async {
    return await loginRepo.login(email: email, password: password);
  }
}
