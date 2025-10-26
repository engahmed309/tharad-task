part of 'verify_otp_api_cubit.dart';

@immutable
sealed class VerifyOtpApiState {
  const VerifyOtpApiState();
  List<Object> get props => [];
}

final class VerifyOtpApiInitial extends VerifyOtpApiState {}

class VerifyOtpApiLoading extends VerifyOtpApiState {
  const VerifyOtpApiLoading();
}

class VerifyOtpApiSuccessful extends VerifyOtpApiState {
  final SimpleModel response;

  const VerifyOtpApiSuccessful(this.response);
}

class VerifyOtpApiFailed extends VerifyOtpApiState {
  final String message;
  const VerifyOtpApiFailed(this.message);
}
