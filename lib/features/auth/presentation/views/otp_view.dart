import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tharad_tech_task/core/utils/helper.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/widgets/custom_button.dart';
import '../widgets/otp/otp_timer.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: context.screenHeight * .1),

                /// Logo
                Center(child: Image.asset(AssetsData.logo, height: 60)),
                SizedBox(height: context.screenHeight * .1),

                /// Title
                Text('رمز التحقق', style: Styles.textStyle24),
                const SizedBox(height: 8),
                SizedBox(
                  width: context.screenWidth - 88,
                  child: Text(
                    'لاستكمال فتح حسابك ادخل رمز التحقق المرسل عبر البريد الإلكتروني',
                    style: Styles.textStyle10.copyWith(
                      fontSize: 12,
                      color: kGreyTextColor,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),

                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      cursorColor: kPrimaryColor,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 49,
                        fieldWidth: 49,

                        /// اللون الأساسي للمربعات
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        selectedFillColor: Colors.white,

                        /// لون البوردر
                        inactiveColor: const Color(0xFFF0E6DE),
                        selectedColor: kPrimaryColor,
                        activeColor: const Color(0xFFF0E6DE),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      keyboardType: TextInputType.number,
                      enableActiveFill: true,
                      onChanged: (value) {},
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                /// Resend & Timer Row
                OtpTimerWidget(),

                const SizedBox(height: 40),

                /// Continue Button
                CustomButton(
                  gradientColors: const [Color(0xff5CC7A3), Color(0xff265355)],
                  onPressed: () {},
                  btnText: "المتابعة",
                  txtStyle: Styles.textStyle16.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
