part of 'login_api_cubit.dart';

@immutable
sealed class LoginApiState {
  const LoginApiState();
  List<Object> get props => [];
}

final class LoginApiInitial extends LoginApiState {}

class LoginApiLoading extends LoginApiState {
  const LoginApiLoading();
}

class LoginApiSuccessful extends LoginApiState {
  final LoginModel response;

  const LoginApiSuccessful(this.response);
}

class LoginApiFailed extends LoginApiState {
  final String message;
  const LoginApiFailed(this.message);
}
