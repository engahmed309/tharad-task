import '../../data/data_source/auth_remote_data_source.dart';
import '../../data/models/otp_model.dart';
import '../repos/auth_repo.dart';

abstract class UseCase<type> {
  Future<OtpResponse> call({required String email, required String otp});
}

class OtpUseCase extends UseCase<SimpleModel> {
  final OtpRepo otpRepo;
  OtpUseCase(this.otpRepo);

  @override
  Future<OtpResponse> call({required String email, required String otp}) async {
    return await otpRepo.verifyOtp(email: email, otp: otp);
  }
}
