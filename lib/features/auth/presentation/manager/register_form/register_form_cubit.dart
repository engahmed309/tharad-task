import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'register_form_state.dart';

class RegisterFormCubit extends Cubit<RegisterFormState> {
  RegisterFormCubit() : super(RegisterFormInitial());

  static RegisterFormCubit get(BuildContext context) =>
      BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final oldPasswordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      emit(RegisterFormImageLoading());

      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 70,
      );
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        emit(RegisterFormImagePicked(selectedImage!));
      } else {
        emit(RegisterFormInitial());
      }
    } catch (e) {
      emit(RegisterFormImageError("حدث خطأ أثناء اختيار الصورة"));
    }
  }

  void clearImage() {
    selectedImage = null;
    emit(RegisterFormImageCleared());
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(RegisterFormPasswordVisibilityChanged());
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(RegisterFormPasswordVisibilityChanged());
  }

  bool validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      emit(RegisterFormValid());
      return true;
    } else {
      emit(RegisterFormInvalid());
      return false;
    }
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'الاسم مطلوب';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'البريد الإلكتروني مطلوب';
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) return 'صيغة البريد غير صحيحة';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'كلمة المرور مطلوبة';
    if (value.length < 6) return 'كلمة المرور قصيرة جدًا';
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value != passwordController.text) return 'كلمتا المرور غير متطابقتين';
    return null;
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
