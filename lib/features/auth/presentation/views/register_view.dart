import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad_tech_task/core/utils/assets.dart';
import 'package:tharad_tech_task/core/utils/constants.dart';
import 'package:tharad_tech_task/core/utils/gaps.dart';
import 'package:tharad_tech_task/core/utils/helper.dart';
import 'package:tharad_tech_task/core/utils/styles.dart';
import 'package:tharad_tech_task/core/utils/widgets/custom_button.dart';
import 'package:tharad_tech_task/core/utils/widgets/custom_text_field.dart';

import '../manager/register_api/register_api_cubit.dart';
import '../manager/register_form/register_form_cubit.dart';
import '../widgets/register/have_account_text.dart';
import '../widgets/register/image_picker_widget.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterFormCubit, RegisterFormState>(
      builder: (context, state) {
        final formCubit = RegisterFormCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.white,

          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formCubit.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.screenHeight * .05),
                    Center(child: Image.asset(AssetsData.logo)),
                    SizedBox(height: context.screenHeight * .05),
                    Center(
                      child: Text('إنشاء حساب جديد', style: Styles.textStyle24),
                    ),
                    const SizedBox(height: 24),
                    // IMAGE
                    Text("الصورة الشخصية", style: Styles.textStyle10),
                    Gaps.vGap6,
                    ImagePickerWidget(),

                    // الاسم
                    Text("اسم المستخدم", style: Styles.textStyle10),
                    Gaps.vGap6,
                    CustomTextField(
                      controller: formCubit.nameController,
                      hint: "أدخل اسم المستخدم",
                      validator: formCubit.validateName,
                    ),
                    const SizedBox(height: 15),

                    // الإيميل
                    Text("البريد الإلكتروني", style: Styles.textStyle10),
                    Gaps.vGap6,
                    CustomTextField(
                      controller: formCubit.emailController,
                      hint: "example@email.com",
                      validator: formCubit.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),

                    // كلمة المرور
                    Text("كلمة المرور", style: Styles.textStyle10),
                    Gaps.vGap6,
                    CustomTextField(
                      controller: formCubit.passwordController,
                      isPassword: !formCubit.isPasswordVisible,
                      validator: formCubit.validatePassword,
                      suffixIcon: formCubit.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      suffix: IconButton(
                        icon: Icon(
                          formCubit.isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: kPrimaryColor,
                        ),
                        onPressed: formCubit.togglePasswordVisibility,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // تأكيد كلمة المرور
                    Text("تأكيد كلمة المرور", style: Styles.textStyle10),
                    Gaps.vGap6,
                    CustomTextField(
                      controller: formCubit.confirmPasswordController,
                      isPassword: !formCubit.isConfirmPasswordVisible,
                      validator: formCubit.validateConfirmPassword,
                      suffix: IconButton(
                        icon: Icon(
                          formCubit.isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: kPrimaryColor,
                        ),
                        onPressed: formCubit.toggleConfirmPasswordVisibility,
                      ),
                    ),

                    const SizedBox(height: 30),

                    //  التسجيل
                    BlocConsumer<RegisterApiCubit, RegisterApiState>(
                      listener: (context, state) {
                        if (state is RegisterApiSuccessful) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: kPrimaryColor,
                              content: Text(
                                state.response.message ?? "Success",
                              ),
                            ),
                          );

                          Navigator.pushNamed(context, otpRoute);
                        }
                        if (state is RegisterApiFailed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "${state.message}The email has already been taken.",
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return state is RegisterApiLoading
                            ? Center(
                                child: const CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              )
                            : CustomButton(
                                gradientColors: [
                                  Color(0xff5CC7A3),
                                  Color(0xff265355),
                                ],

                                onPressed: () async {
                                  final valid = formCubit.validateForm();
                                  if (valid) {
                                    await context
                                        .read<RegisterApiCubit>()
                                        .register(
                                          email: formCubit.emailController.text,
                                          userName:
                                              formCubit.nameController.text,
                                          password:
                                              formCubit.passwordController.text,
                                          confirmPassword: formCubit
                                              .confirmPasswordController
                                              .text,
                                          image: formCubit.selectedImage!,
                                        );
                                  }
                                },
                                btnText: "إنشاء حساب جديد",
                                txtStyle: Styles.textStyle16.copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              );
                      },
                    ),
                    const SizedBox(height: 20),

                    Center(
                      child: HaveAccountText(
                        normalText: "لديك حساب بالفعل؟ ",
                        actionText: "تسجيل الدخول",
                        onTap: () {
                          Navigator.pushReplacementNamed(context, loginRoute);
                        },
                      ),
                    ),
                    SizedBox(height: context.screenHeight * .05),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
