import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tharad_tech_task/features/auth/domain/use_cases/login_use_case.dart';

import '../../../data/models/login_model/login_model.dart';

part 'login_api_state.dart';

class LoginApiCubit extends Cubit<LoginApiState> {
  LoginApiCubit(this.loginUseCase) : super(LoginApiInitial());
  LoginUseCase loginUseCase;

  Future<void> login({required String email, required String password}) async {
    emit(const LoginApiLoading());
    final result = await loginUseCase.call(password: password, email: email);

    emit(result.fold(LoginApiFailed.new, LoginApiSuccessful.new));
  }
}
