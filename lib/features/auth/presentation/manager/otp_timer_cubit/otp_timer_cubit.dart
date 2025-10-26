import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'otp_timer_state.dart';

class OtpTimerCubit extends Cubit<OtpTimerState> {
  OtpTimerCubit() : super(OtpInitial());

  static const int _initialSeconds = 59;
  Timer? _timer;
  int _currentSeconds = _initialSeconds;

  void startTimer() {
    _timer?.cancel();
    _currentSeconds = _initialSeconds;
    emit(OtpTimerTick(_currentSeconds, false));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentSeconds--;
      if (_currentSeconds > 0) {
        emit(OtpTimerTick(_currentSeconds, false));
      } else {
        timer.cancel();
        emit(OtpTimerTick(0, true)); // انتهى الوقت
      }
    });
  }

  void resendCode() {
    // هنا ممكن تضيف كود API فعلي بعدين
    startTimer();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
