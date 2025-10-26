import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tharad_tech_task/features/profile/domain/use_cases/profile_use_case.dart';

import '../../../data/models/profile_details_model/profile_details_model.dart';

part 'profile_details_state.dart';

class ProfileDetailsCubit extends Cubit<ProfileDetailsState> {
  ProfileDetailsCubit(this.profileUseCase) : super(ProfileDetailsInitial());

  final ProfileUseCase profileUseCase;
  bool _hasLoaded = false;

  Future<void> getProfileData({required String token}) async {
    if (_hasLoaded) return;

    emit(const ProfileDetailsLoading());
    final result = await profileUseCase.call(token: token);
    result.fold((failure) => emit(ProfileDetailsFailed(failure)), (data) {
      emit(ProfileDetailsSuccessful(data));
      _hasLoaded = true;
    });
  }
}
