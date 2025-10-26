// Otp repo
import 'dart:io';

import '../../data/data_source/profile_remote_data_source.dart';

abstract class ProfileRepo {
  Future<ProfileResponse> getProfileData({required String token});
}

// update profile
abstract class UpdateProfileRepo {
  Future<ProfileResponse> updateProfileData({
    required String email,
    required String userName,
    required String password,
    required String newPassword,
    required String newPasswordConfirmation,
    required File image,
  });
}
