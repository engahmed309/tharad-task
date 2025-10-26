import 'package:flutter/material.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';

class HaveAccountText extends StatelessWidget {
  final String normalText;
  final String actionText;
  final VoidCallback? onTap;
  final bool isEnabled;

  const HaveAccountText({
    super.key,
    required this.normalText,
    required this.actionText,
    this.onTap,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          normalText,
          style: Styles.textStyle10.copyWith(fontSize: 12, color: kTextColor),
        ),
        GestureDetector(
          onTap: isEnabled ? onTap : null,
          child: Text(
            actionText,
            style: Styles.textStyle10.copyWith(
              color: isEnabled ? kPrimaryColor : kGreyTextColor,
              fontSize: 12,
              decoration: TextDecoration.underline,
              decorationColor: isEnabled ? kPrimaryColor : kGreyTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
