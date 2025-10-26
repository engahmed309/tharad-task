import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad_tech_task/core/utils/assets.dart';
import 'package:tharad_tech_task/core/utils/constants.dart';
import 'package:tharad_tech_task/core/utils/gaps.dart';
import 'package:tharad_tech_task/core/utils/helper.dart';
import 'package:tharad_tech_task/core/utils/styles.dart';
import 'package:tharad_tech_task/core/utils/widgets/custom_button.dart';
import 'package:tharad_tech_task/core/utils/widgets/custom_text_field.dart';

import '../manager/register_form/register_form_cubit.dart';
import '../widgets/register/have_account_text.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterFormCubit, RegisterFormState>(
      builder: (context, state) {
        final cubit = RegisterFormCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.white,

          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: cubit.formKey,
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

                    // الاسم
                    Text("اسم المستخدم", style: Styles.textStyle10),
                    Gaps.vGap6,
                    CustomTextField(
                      controller: cubit.nameController,
                      hint: "أدخل اسم المستخدم",
                      validator: cubit.validateName,
                    ),
                    const SizedBox(height: 15),

                    // الإيميل
                    Text("البريد الإلكتروني", style: Styles.textStyle10),
                    Gaps.vGap6,
                    CustomTextField(
                      controller: cubit.emailController,
                      hint: "example@email.com",
                      validator: cubit.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),

                    // كلمة المرور
                    Text("كلمة المرور", style: Styles.textStyle10),
                    Gaps.vGap6,
                    CustomTextField(
                      controller: cubit.passwordController,
                      isPassword: !cubit.isPasswordVisible,
                      validator: cubit.validatePassword,
                      suffixIcon: cubit.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      suffix: IconButton(
                        icon: Icon(
                          cubit.isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: kPrimaryColor,
                        ),
                        onPressed: cubit.togglePasswordVisibility,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // تأكيد كلمة المرور
                    Text("تأكيد كلمة المرور", style: Styles.textStyle10),
                    Gaps.vGap6,
                    CustomTextField(
                      controller: cubit.confirmPasswordController,
                      isPassword: !cubit.isConfirmPasswordVisible,
                      validator: cubit.validateConfirmPassword,
                      suffix: IconButton(
                        icon: Icon(
                          cubit.isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: kPrimaryColor,
                        ),
                        onPressed: cubit.toggleConfirmPasswordVisibility,
                      ),
                    ),

                    const SizedBox(height: 30),

                    //  التسجيل
                    CustomButton(
                      gradientColors: [Color(0xff5CC7A3), Color(0xff265355)],

                      onPressed: () {
                        //for testing
                        Navigator.pushNamed(context, otpRoute);
                        final valid = cubit.validateForm();
                        if (valid) {}
                      },
                      btnText: "إنشاء حساب جديد",
                      txtStyle: Styles.textStyle16.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                      ),
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
