part of 'login_form_cubit.dart';

abstract class LoginFormState {}

class LoginFormInitial extends LoginFormState {}

class LoginPasswordVisibilityChanged extends LoginFormState {}

class LoginRememberMeChanged extends LoginFormState {}

class LoginValidationFailed extends LoginFormState {}
