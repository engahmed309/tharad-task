import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tharad_tech_task/features/auth/domain/use_cases/register_use_case.dart';

import '../../../data/models/register_model/register_model.dart';

part 'register_api_state.dart';

class RegisterApiCubit extends Cubit<RegisterApiState> {
  RegisterApiCubit(this.registerUseCase) : super(RegisterApiInitial());
  final RegisterUseCase registerUseCase;

  Future<void> register({
    required String email,
    required String userName,
    required String password,
    required String confirmPassword,
    required File image,
  }) async {
    emit(const RegisterApiLoading());
    final result = await registerUseCase.call(
      confirmPassword: confirmPassword,
      password: password,
      userName: userName,
      email: email,
      image: image,
    );

    emit(result.fold(RegisterApiFailed.new, RegisterApiSuccessful.new));
  }
}
