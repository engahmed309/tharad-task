import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tharad_tech_task/core/utils/constants.dart';
import 'package:tharad_tech_task/core/utils/styles.dart';

class HaveAccountText extends StatelessWidget {
  final String normalText;
  final String actionText;
  final VoidCallback onTap;

  const HaveAccountText({
    super.key,
    required this.normalText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: normalText,
        style: Styles.textStyle10.copyWith(fontSize: 12, color: kTextColor),
        children: [
          TextSpan(
            text: actionText,
            style: Styles.textStyle10.copyWith(
              fontSize: 12,
              color: kPrimaryColor,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
