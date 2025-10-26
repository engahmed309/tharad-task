import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tharad_tech_task/features/auth/domain/use_cases/otp_use_case.dart';

import '../../../data/models/otp_model.dart';

part 'verify_otp_api_state.dart';

class VerifyOtpApiCubit extends Cubit<VerifyOtpApiState> {
  VerifyOtpApiCubit(this.otpUseCase) : super(VerifyOtpApiInitial());
  OtpUseCase otpUseCase;
  Future<void> verifyOtp({required String email, required String otp}) async {
    emit(const VerifyOtpApiLoading());
    final result = await otpUseCase.call(otp: otp, email: email);

    emit(result.fold(VerifyOtpApiFailed.new, VerifyOtpApiSuccessful.new));
  }
}
