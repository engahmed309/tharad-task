import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad_tech_task/core/utils/helper.dart';
import 'package:tharad_tech_task/core/utils/widgets/custom_button.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/gaps.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/widgets/custom_text_field.dart';
import '../../../auth/presentation/manager/register_form/register_form_cubit.dart';
import '../../../auth/presentation/widgets/register/image_picker_widget.dart';
import '../widgets/simple_app_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff5CC7A3), Color(0xff265355)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ===== AppBar Section =====
              SimpleAppBar(),
              // ===== Form Section =====
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: BlocBuilder<RegisterFormCubit, RegisterFormState>(
                    builder: (context, state) {
                      final formCubit = RegisterFormCubit.get(context);

                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // الاسم
                            Text("اسم المستخدم", style: Styles.textStyle10),
                            Gaps.vGap6,
                            CustomTextField(
                              controller: formCubit.nameController,
                              validator: formCubit.validateName,
                            ),
                            const SizedBox(height: 15),

                            // الإيميل
                            Text(
                              "البريد الإلكتروني",
                              style: Styles.textStyle10,
                            ),
                            Gaps.vGap6,
                            CustomTextField(
                              controller: formCubit.emailController,
                              validator: formCubit.validateEmail,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 15),
                            // IMAGE
                            Text("الصورة الشخصية", style: Styles.textStyle10),
                            Gaps.vGap6,
                            const Center(child: ImagePickerWidget()),
                            Gaps.vGap12,

                            // كلمة المرور
                            Text(
                              "كلمة المرور القديمة",
                              style: Styles.textStyle10,
                            ),
                            Gaps.vGap6,
                            CustomTextField(
                              controller: formCubit.oldPasswordController,
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
                            const SizedBox(height: 15),

                            //                               "كلمة المرور الجديدة",
                            Text(
                              "كلمة المرور الجديدة",
                              style: Styles.textStyle10,
                            ),
                            Gaps.vGap6,
                            CustomTextField(
                              controller: formCubit.passwordController,
                              isPassword: !formCubit.isConfirmPasswordVisible,
                              validator: formCubit.validateConfirmPassword,
                              suffix: IconButton(
                                icon: Icon(
                                  formCubit.isConfirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: kPrimaryColor,
                                ),
                                onPressed:
                                    formCubit.toggleConfirmPasswordVisibility,
                              ),
                            ),
                            const SizedBox(height: 15),

                            //                               "كلمة المرور الجديدة",
                            Text(
                              "تأكيد كلمة المرور الجديدة",
                              style: Styles.textStyle10,
                            ),
                            Gaps.vGap6,
                            CustomTextField(
                              controller: formCubit.passwordController,
                              isPassword: !formCubit.isConfirmPasswordVisible,
                              validator: formCubit.validateConfirmPassword,
                              suffix: IconButton(
                                icon: Icon(
                                  formCubit.isConfirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: kPrimaryColor,
                                ),
                                onPressed:
                                    formCubit.toggleConfirmPasswordVisibility,
                              ),
                            ),
                            const SizedBox(height: 50),
                            CustomButton(
                              gradientColors: [
                                Color(0xff5CC7A3),
                                Color(0xff265355),
                              ],
                              onPressed: () {},
                              btnText: "حفظ التغيرات",
                              width: context.screenWidth - 116,
                            ),
                            const SizedBox(height: 12),
                            Center(
                              child: Text(
                                "تسجيل الخروج",
                                style: Styles.textStyle10.copyWith(
                                  color: kRedColor,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  fontSize: 12,
                                  decorationColor: kRedColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
