part of 'update_profile_cubit.dart';

@immutable
sealed class UpdateProfileState {
  const UpdateProfileState();
  List<Object> get props => [];
}

final class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {
  const UpdateProfileLoading();
}

class UpdateProfileSuccessful extends UpdateProfileState {
  final ProfileDetailsModel response;

  const UpdateProfileSuccessful(this.response);
}

class UpdateProfileFailed extends UpdateProfileState {
  final String message;
  const UpdateProfileFailed(this.message);
}
