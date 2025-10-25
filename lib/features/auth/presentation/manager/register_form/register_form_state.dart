part of 'register_form_cubit.dart';

@immutable
sealed class RegisterFormState {}

final class RegisterFormInitial extends RegisterFormState {}

final class RegisterFormValid extends RegisterFormState {}

final class RegisterFormInvalid extends RegisterFormState {}

final class RegisterFormPasswordVisibilityChanged extends RegisterFormState {}
