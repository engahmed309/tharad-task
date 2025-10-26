part of 'otp_timer_cubit.dart';

@immutable
sealed class OtpTimerState {}

final class OtpInitial extends OtpTimerState {}

final class OtpTimerTick extends OtpTimerState {
  final int remainingSeconds;
  final bool isExpired;

  OtpTimerTick(this.remainingSeconds, this.isExpired);
}
