import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginFormState> {
  LoginFormCubit() : super(LoginFormInitial());

  static LoginFormCubit get(BuildContext context) => BlocProvider.of(context);

  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Password visibility
  bool isPasswordVisible = false;

  // Remember Me
  bool rememberMe = false;

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginPasswordVisibilityChanged());
  }

  // Toggle remember me checkbox
  void toggleRememberMe() {
    rememberMe = !rememberMe;
    emit(LoginRememberMeChanged());
  }

  // Validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'البريد الإلكتروني مطلوب';
    if (!value.contains('@')) return 'صيغة البريد غير صحيحة';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'كلمة المرور مطلوبة';
    if (value.length < 6) return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    return null;
  }

  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    }
    emit(LoginValidationFailed());
    return false;
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
