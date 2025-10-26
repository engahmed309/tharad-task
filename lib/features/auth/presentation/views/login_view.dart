import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tharad_tech_task/core/utils/assets.dart';
import 'package:tharad_tech_task/core/utils/constants.dart';
import 'package:tharad_tech_task/core/utils/gaps.dart';
import 'package:tharad_tech_task/core/utils/helper.dart';
import 'package:tharad_tech_task/core/utils/styles.dart';
import 'package:tharad_tech_task/core/utils/widgets/custom_button.dart';
import 'package:tharad_tech_task/core/utils/widgets/custom_text_field.dart';

import '../manager/login_api/login_api_cubit.dart';
import '../manager/login_form/login_form_cubit.dart';
import '../widgets/login/forget_pass_remmeber_me.dart';
import '../widgets/register/have_account_text.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormCubit, LoginFormState>(
      builder: (context, state) {
        final formCubit = LoginFormCubit.get(context);

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
                    SizedBox(height: context.screenHeight * .1),

                    // Logo
                    Center(child: Image.asset(AssetsData.logo)),
                    SizedBox(height: context.screenHeight * .1),

                    // Title
                    Center(
                      child: Text('تسجيل الدخول', style: Styles.textStyle24),
                    ),
                    const SizedBox(height: 24),

                    // Email
                    Text("البريد الإلكتروني", style: Styles.textStyle10),
                    Gaps.vGap6,
                    CustomTextField(
                      controller: formCubit.emailController,
                      validator: formCubit.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),

                    // Password
                    Text("كلمة المرور", style: Styles.textStyle10),
                    Gaps.vGap6,
                    CustomTextField(
                      controller: formCubit.passwordController,
                      isPassword: !formCubit.isPasswordVisible,
                      validator: formCubit.validatePassword,
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
                    const SizedBox(height: 8),

                    // Forgot password & Remember me
                    ForgetPasswordRememberMe(cubit: formCubit),

                    SizedBox(height: 20),

                    // Login button
                    BlocConsumer<LoginApiCubit, LoginApiState>(
                      listener: (context, state) async {
                        if (state is LoginApiSuccessful) {
                          Hive.box(
                            kAccessTokenBox,
                          ).put(kAccessTokenBox, state.response.data!.token);
                          if (formCubit.rememberMe) {
                            Hive.box(kRememberEmailBox).put(
                              kRememberEmailBox,
                              formCubit.emailController.text,
                            );
                            Hive.box(kRememberPasswordBox).put(
                              kRememberPasswordBox,
                              formCubit.passwordController.text,
                            );
                          } else {
                            Hive.box(
                              kRememberEmailBox,
                            ).delete(kRememberEmailBox);
                            Hive.box(
                              kRememberPasswordBox,
                            ).delete(kRememberPasswordBox);
                          }

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            profileRoute,
                            (route) => false,
                          );
                        }
                        if (state is LoginApiFailed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(state.message),
                            ),
                          );
                          if (state.message.startsWith("403")) {
                            Navigator.pushNamed(
                              context,
                              otpRoute,
                              arguments: formCubit.emailController.text,
                            );
                          }
                        }
                      },
                      builder: (context, state) {
                        return state is LoginApiLoading
                            ? Center(
                                child: const CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              )
                            : CustomButton(
                                gradientColors: const [
                                  Color(0xff5CC7A3),
                                  Color(0xff265355),
                                ],
                                onPressed: () async {
                                  final valid = formCubit.validateForm();
                                  if (valid) {
                                    await context.read<LoginApiCubit>().login(
                                      email: formCubit.emailController.text,
                                      password:
                                          formCubit.passwordController.text,
                                    );
                                  }
                                },
                                btnText: "تسجيل الدخول",
                                txtStyle: Styles.textStyle16.copyWith(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              );
                      },
                    ),

                    const SizedBox(height: 12),

                    // Have account text
                    Center(
                      child: HaveAccountText(
                        normalText: "ليس لديك حساب؟ ",
                        actionText: "إنشاء حساب جديد",
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            registerRoute,
                          );
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
