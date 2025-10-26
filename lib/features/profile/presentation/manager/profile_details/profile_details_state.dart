part of 'profile_details_cubit.dart';

@immutable
sealed class ProfileDetailsState {
  const ProfileDetailsState();
  List<Object> get props => [];
}

final class ProfileDetailsInitial extends ProfileDetailsState {}

class ProfileDetailsLoading extends ProfileDetailsState {
  const ProfileDetailsLoading();
}

class ProfileDetailsSuccessful extends ProfileDetailsState {
  final ProfileDetailsModel response;

  const ProfileDetailsSuccessful(this.response);
}

class ProfileDetailsFailed extends ProfileDetailsState {
  final String message;
  const ProfileDetailsFailed(this.message);
}
