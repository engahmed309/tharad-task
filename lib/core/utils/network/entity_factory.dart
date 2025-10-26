import '../../../features/auth/data/models/login_model/login_model.dart';
import '../../../features/auth/data/models/otp_model.dart';
import '../../../features/auth/data/models/register_model/register_model.dart';
import '../../../features/profile/data/models/profile_details_model/profile_details_model.dart';
import 'base_response/general_response.dart';
import 'net_response.dart';

class EntityFactory {
  static T? generateOBJ<T>(json) {
    if (T.toString() == "BaseResponse") {
      return BaseResponse.fromJson(json) as T;
    } else if (T.toString() == "GeneralResponse") {
      return GeneralResponse.fromJson(json) as T;
    } else if (T.toString() == "RegisterModel") {
      return RegisterModel.fromJson(json) as T;
    } else if (T.toString() == "LoginModel") {
      return LoginModel.fromJson(json) as T;
    } else if (T.toString() == "OtpModel") {
      return SimpleModel.fromJson(json) as T;
    } else if (T.toString() == "ProfileDetailsModel") {
      return ProfileDetailsModel.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
