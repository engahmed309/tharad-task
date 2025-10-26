import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tharad_tech_task/features/profile/data/models/profile_details_model/profile_details_model.dart';
import 'package:tharad_tech_task/features/profile/domain/use_cases/update_propfile_use_case.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(this.updateProfileUseCase) : super(UpdateProfileInitial());
  UpdateProfileUseCase updateProfileUseCase;

  Future<void> updateProfile({
    required String email,
    required String userName,
    required String password,
    required String newPassword,
    required String newPasswordConfirmation,
    required File image,
  }) async {
    emit(const UpdateProfileLoading());
    final result = await updateProfileUseCase.call(
      email: email,
      userName: userName,
      password: password,
      newPassword: newPassword,
      newPasswordConfirmation: newPasswordConfirmation,
      image: image,
    );
    result.fold((failure) => emit(UpdateProfileFailed(failure)), (data) {
      emit(UpdateProfileSuccessful(data));
    });
  }
}
