import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tharad_tech_task/core/utils/constants.dart';

import '../../../../core/utils/functions/setup_service_locator.dart';
import '../../../../core/utils/network/api/network_api.dart';
import '../../../../core/utils/network/network_request.dart';
import '../../../../core/utils/network/network_utils.dart';
import '../models/profile_details_model/profile_details_model.dart';

typedef ProfileResponse = Either<String, ProfileDetailsModel>;

abstract class ProfileRemoteDataSource {
  Future<ProfileResponse> getProfileData({required String token});
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  @override
  Future<ProfileResponse> getProfileData({required String token}) async {
    ProfileResponse profileResponse = left("");

    try {
      await getIt<NetworkRequest>().requestFutureData<ProfileDetailsModel>(
        Method.get,
        url: Api.profile,
        options: Options(
          //   contentType: 'application/json',
          headers: {'Authorization': 'Bearer $token'},
        ),
        onSuccess: (data) {
          profileResponse = right(data);
        },
        onError: (code, msg) {
          profileResponse = left("$msg ($code)");
        },
      );
    } catch (e) {
      profileResponse = left("Unexpected error: $e");
    }

    return profileResponse;
  }
}
// Update Profile

typedef UpdateProfileResponse = Either<String, ProfileDetailsModel>;

abstract class UpdateProfileRemoteDataSource {
  Future<UpdateProfileResponse> updateProfile({
    required String email,
    required String userName,
    required String password,
    required String newPassword,
    required String newPasswordConfirmation,
    required File image,
  });
}

class UpdateProfileRemoteDataSourceImpl extends UpdateProfileRemoteDataSource {
  @override
  Future<UpdateProfileResponse> updateProfile({
    required String email,
    required String userName,
    required String password,
    required String newPassword,
    required String newPasswordConfirmation,
    required File image,
  }) async {
    UpdateProfileResponse updateProfileResponse = left("");

    try {
      final formData = FormData.fromMap({
        "email": email,
        "username": userName,
        "password": password,
        "new_password": newPassword,
        "new_password_confirmation": newPasswordConfirmation,
        "_method": "PUT",
        "image": await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      await getIt<NetworkRequest>().requestFutureData<ProfileDetailsModel>(
        Method.post,
        url: Api.updateProfile,
        formData: formData,
        isFormData: true,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {
            'Authorization':
                'Bearer ${Hive.box(kAccessTokenBox).get(kAccessTokenBox)}',
          },
        ),
        onSuccess: (data) {
          if (data.status == "success") {
            updateProfileResponse = right(data);
          } else {
            updateProfileResponse = left(data.message ?? 'Unknown error');
          }
        },
        onError: (code, msg) {
          if (code == 422) {
            updateProfileResponse = left(
              "${"The email or user name has already been taken."} ($code)",
            );
          } else {
            updateProfileResponse = left("$msg ($code)");
          }
        },
      );
    } catch (e) {
      updateProfileResponse = left("Unexpected error: $e");
    }

    return updateProfileResponse;
  }
}
