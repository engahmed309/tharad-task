import 'dart:io';

import '../../data/data_source/profile_remote_data_source.dart';
import '../../data/models/profile_details_model/profile_details_model.dart';
import '../repos/profile_repo.dart';

abstract class UseCase<type> {
  Future<UpdateProfileResponse> call({
    required String email,
    required String userName,
    required String password,
    required String newPassword,
    required String newPasswordConfirmation,
    required File image,
  });
}

class UpdateProfileUseCase extends UseCase<ProfileDetailsModel> {
  final UpdateProfileRepo updateProfileRepo;
  UpdateProfileUseCase(this.updateProfileRepo);

  @override
  Future<UpdateProfileResponse> call({
    required String email,
    required String userName,
    required String password,
    required String newPassword,
    required String newPasswordConfirmation,
    required File image,
  }) async {
    return await updateProfileRepo.updateProfileData(
      email: email,
      userName: userName,
      password: password,
      newPassword: newPassword,
      newPasswordConfirmation: newPasswordConfirmation,
      image: image,
    );
  }
}
