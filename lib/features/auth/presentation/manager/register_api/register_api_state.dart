part of 'register_api_cubit.dart';

@immutable
sealed class RegisterApiState {
  const RegisterApiState();
  List<Object> get props => [];
}

final class RegisterApiInitial extends RegisterApiState {}

class RegisterApiLoading extends RegisterApiState {
  const RegisterApiLoading();
}

class RegisterApiSuccessful extends RegisterApiState {
  final RegisterModel response;

  const RegisterApiSuccessful(this.response);
}

class RegisterApiFailed extends RegisterApiState {
  final String message;
  const RegisterApiFailed(this.message);
}
