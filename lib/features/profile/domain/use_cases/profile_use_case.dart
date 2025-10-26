import '../../data/data_source/profile_remote_data_source.dart';
import '../../data/models/profile_details_model/profile_details_model.dart';
import '../repos/profile_repo.dart';

abstract class UseCase<type> {
  Future<ProfileResponse> call({required String token});
}

class ProfileUseCase extends UseCase<ProfileDetailsModel> {
  final ProfileRepo profileRepo;
  ProfileUseCase(this.profileRepo);

  @override
  Future<ProfileResponse> call({required String token}) async {
    return await profileRepo.getProfileData(token: token);
  }
}
