import 'dart:io';

import '../../domain/repos/profile_repo.dart';
import '../data_source/profile_remote_data_source.dart';

class ProfileRepoImpl extends ProfileRepo {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepoImpl(this.profileRemoteDataSource);

  @override
  Future<ProfileResponse> getProfileData({required String token}) async {
    var response = await profileRemoteDataSource.getProfileData(token: token);
    return response;
  }
}

// update profile
class UpdateProfileRepoImpl extends UpdateProfileRepo {
  final UpdateProfileRemoteDataSource updateProfileRemoteDataSource;

  UpdateProfileRepoImpl(this.updateProfileRemoteDataSource);

  @override
  Future<ProfileResponse> updateProfileData({
    required String email,
    required String userName,
    required String password,
    required String newPassword,
    required String newPasswordConfirmation,
    required File image,
  }) async {
    var response = await updateProfileRemoteDataSource.updateProfile(
      email: email,
      userName: userName,
      password: password,
      newPassword: newPassword,
      newPasswordConfirmation: newPasswordConfirmation,
      image: image,
    );
    return response;
  }
}
