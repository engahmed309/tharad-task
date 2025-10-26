part of 'register_form_cubit.dart';

@immutable
sealed class RegisterFormState {}

final class RegisterFormInitial extends RegisterFormState {}

final class RegisterFormValid extends RegisterFormState {}

final class RegisterFormInvalid extends RegisterFormState {}

final class RegisterFormPasswordVisibilityChanged extends RegisterFormState {}

final class RegisterFormImageLoading extends RegisterFormState {}

final class RegisterFormImagePicked extends RegisterFormState {
  final File image;
  RegisterFormImagePicked(this.image);
}

final class RegisterFormImageCleared extends RegisterFormState {}

final class RegisterFormImageError extends RegisterFormState {
  final String message;
  RegisterFormImageError(this.message);
}
