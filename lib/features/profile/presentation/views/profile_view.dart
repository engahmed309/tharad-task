import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tharad_tech_task/core/utils/helper.dart';
import 'package:tharad_tech_task/core/utils/widgets/custom_button.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/gaps.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/widgets/custom_text_field.dart';
import '../../../auth/presentation/manager/register_form/register_form_cubit.dart';
import '../../../auth/presentation/widgets/register/image_picker_widget.dart';
import '../../domain/entity/user_data_entity.dart';
import '../manager/profile_details/profile_details_cubit.dart';
import '../manager/update_profile/update_profile_cubit.dart';
import '../widgets/simple_app_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final tokenBox = Hive.box(kAccessTokenBox);
    final token = tokenBox.get(kAccessTokenBox);

    final userDataBox = Hive.box<UserDataEntity>(kUserDataBox);
    final storedUser = userDataBox.get(kUserDataBox);

    if (storedUser == null && token != null) {
      context.read<ProfileDetailsCubit>().getProfileData(token: token);
    }

    final formCubit = RegisterFormCubit.get(context);

    // أنشئ Controllers جديدة لكلمة المرور الجديدة والتأكيد
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    // عند وجود بيانات مخزنة
    if (storedUser != null) {
      formCubit.nameController.text = storedUser.username ?? '';
      formCubit.emailController.text = storedUser.email ?? '';
    }

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
              const SimpleAppBar(),

              BlocConsumer<ProfileDetailsCubit, ProfileDetailsState>(
                listener: (context, state) async {
                  if (state is ProfileDetailsSuccessful) {
                    final apiData = state.response.data;
                    if (apiData != null) {
                      final userEntity = UserDataEntity(
                        id: apiData.id,
                        username: apiData.username,
                        email: apiData.email,
                        image: apiData.image,
                      );
                      await userDataBox.put(kUserDataBox, userEntity);

                      formCubit.nameController.text = userEntity.username ?? '';
                      formCubit.emailController.text = userEntity.email ?? '';
                    }
                  }
                },
                builder: (context, state) {
                  return Expanded(
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
                        builder: (context, formState) {
                          if (state is ProfileDetailsLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            );
                          } else if (state is ProfileDetailsFailed) {
                            return Center(
                              child: Text(
                                state.message,
                                style: Styles.textStyle16.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                            );
                          }

                          return SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("اسم المستخدم", style: Styles.textStyle10),
                                Gaps.vGap6,
                                CustomTextField(
                                  controller: formCubit.nameController,
                                  validator: formCubit.validateName,
                                ),
                                const SizedBox(height: 15),

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

                                Text(
                                  "الصورة الشخصية",
                                  style: Styles.textStyle10,
                                ),
                                Gaps.vGap6,
                                Center(
                                  child: ImagePickerWidget(
                                    imageUrl: storedUser?.image,
                                  ),
                                ),
                                Gaps.vGap12,

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
                                    onPressed:
                                        formCubit.togglePasswordVisibility,
                                  ),
                                ),
                                const SizedBox(height: 15),

                                Text(
                                  "كلمة المرور الجديدة",
                                  style: Styles.textStyle10,
                                ),
                                Gaps.vGap6,
                                CustomTextField(
                                  controller: newPasswordController,
                                  isPassword: !formCubit.isNewPasswordVisible,
                                  validator: formCubit.validatePassword,
                                  suffix: IconButton(
                                    icon: Icon(
                                      formCubit.isNewPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: kPrimaryColor,
                                    ),
                                    onPressed:
                                        formCubit.toggleNewPasswordVisibility,
                                  ),
                                ),
                                const SizedBox(height: 15),

                                Text(
                                  "تأكيد كلمة المرور الجديدة",
                                  style: Styles.textStyle10,
                                ),
                                Gaps.vGap6,
                                CustomTextField(
                                  controller: confirmPasswordController,
                                  isPassword:
                                      !formCubit.isConfirmPasswordVisible,
                                  validator: (val) =>
                                      formCubit.validateConfirmPassword(
                                        newPasswordController.text,
                                      ),
                                  suffix: IconButton(
                                    icon: Icon(
                                      formCubit.isConfirmPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: kPrimaryColor,
                                    ),
                                    onPressed: formCubit
                                        .toggleConfirmPasswordVisibility,
                                  ),
                                ),
                                const SizedBox(height: 50),

                                BlocConsumer<
                                  UpdateProfileCubit,
                                  UpdateProfileState
                                >(
                                  listener: (context, state) async {
                                    final messenger = ScaffoldMessenger.of(
                                      context,
                                    );

                                    if (state is UpdateProfileLoading) {
                                      messenger.showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "جاري تحديث البيانات...",
                                          ),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (state
                                        is UpdateProfileSuccessful) {
                                      final updatedUser = UserDataEntity(
                                        id: storedUser?.id,
                                        username: state.response.username,
                                        email: state.response.email,
                                        image: state.response.image,
                                      );
                                      await userDataBox.put(
                                        kUserDataBox,
                                        updatedUser,
                                      );

                                      formCubit.nameController.text =
                                          updatedUser.username ?? '';
                                      formCubit.emailController.text =
                                          updatedUser.email ?? '';

                                      messenger.showSnackBar(
                                        const SnackBar(
                                          content: Text("تم التحديث بنجاح"),
                                          backgroundColor: kPrimaryColor,
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (state is UpdateProfileFailed) {
                                      messenger.showSnackBar(
                                        SnackBar(
                                          content: Text(state.message),
                                          backgroundColor: Colors.red,
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    return CustomButton(
                                      gradientColors: const [
                                        Color(0xff5CC7A3),
                                        Color(0xff265355),
                                      ],
                                      onPressed: () {
                                        final updateCubit = context
                                            .read<UpdateProfileCubit>();

                                        if (formCubit.selectedImage == null &&
                                            storedUser?.image == null) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text("يرجى اختيار صورة"),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                          return;
                                        }

                                        updateCubit.updateProfile(
                                          email: formCubit.emailController.text
                                              .trim(),
                                          userName: formCubit
                                              .nameController
                                              .text
                                              .trim(),
                                          password: formCubit
                                              .oldPasswordController
                                              .text
                                              .trim(),
                                          newPassword: newPasswordController
                                              .text
                                              .trim(),
                                          newPasswordConfirmation:
                                              confirmPasswordController.text
                                                  .trim(),
                                          image: formCubit.selectedImage != null
                                              ? File(
                                                  formCubit.selectedImage!.path,
                                                )
                                              : File(''), // تعديل حسب الـ API
                                        );
                                      },
                                      btnText: "حفظ التغيرات",
                                      width: context.screenWidth - 116,
                                    );
                                  },
                                ),

                                const SizedBox(height: 12),

                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      tokenBox.clear();
                                      userDataBox.clear();
                                      Navigator.pushReplacementNamed(
                                        context,
                                        loginRoute,
                                      );
                                    },
                                    child: Text(
                                      "تسجيل الخروج",
                                      style: Styles.textStyle10.copyWith(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline,
                                        fontSize: 12,
                                        decorationColor: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
