import 'package:flutter/material.dart';

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
          children: [
            Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              side: const BorderSide(color: kTextColor, width: 1.2),

              value: cubit.rememberMe,
              activeColor: kPrimaryColor,
              onChanged: (v) => cubit.toggleRememberMe(),
            ),
            const Text('تذكرني'),
          ],
        ),
        TextButton(
          onPressed: () {
            // TODO: navigate to forgot password
          },
          child: const Text(
            'هل نسيت كلمة المرور؟',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 12,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
