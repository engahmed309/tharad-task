import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tharad_tech_task/core/utils/constants.dart';
import 'package:tharad_tech_task/core/utils/styles.dart';

class HaveAccountText extends StatelessWidget {
  final VoidCallback onLoginTap;
  const HaveAccountText({super.key, required this.onLoginTap});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'لديك حساب؟ ',
        style: Styles.textStyle10.copyWith(fontSize: 12, color: kTextColor),
        children: [
          TextSpan(
            text: 'تسجيل الدخول',
            style: Styles.textStyle10.copyWith(
              fontSize: 12,
              color: kPrimaryColor,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = onLoginTap,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
