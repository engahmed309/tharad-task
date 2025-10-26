part of 'otp_cubit.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}

final class OtpTimerTick extends OtpState {
  final int remainingSeconds;
  final bool isExpired;

  OtpTimerTick(this.remainingSeconds, this.isExpired);
}
