import 'package:flutter/material.dart';
import 'package:tharad_tech_task/core/utils/styles.dart';

import '../../../../../core/utils/constants.dart';
import '../../manager/login_form/login_form_cubit.dart';

class ForgetPasswordRememberMe extends StatelessWidget {
  const ForgetPasswordRememberMe({super.key, required this.cubit});

  final LoginFormCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 0.9,
              child: Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                side: const BorderSide(color: kTextColor, width: 1.2),
                value: cubit.rememberMe,
                activeColor: kPrimaryColor,
                onChanged: (v) => cubit.toggleRememberMe(),
              ),
            ),
            const Text('تذكرني', style: Styles.textStyle10),
          ],
        ),
        TextButton(
          onPressed: () {
            // TODO: navigate to forgot password
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'هل نسيت كلمة المرور؟',
            style: Styles.textStyle10.copyWith(
              color: kPrimaryColor,
              fontSize: 12,
              decoration: TextDecoration.underline,
              decorationColor: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
