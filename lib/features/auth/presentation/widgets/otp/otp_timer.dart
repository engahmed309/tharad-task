import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad_tech_task/core/utils/constants.dart';
import 'package:tharad_tech_task/core/utils/styles.dart';
import 'package:tharad_tech_task/features/auth/presentation/widgets/register/have_account_text.dart';

import '../../manager/otp_timer_cubit/otp_timer_cubit.dart';

class OtpTimerWidget extends StatelessWidget {
  const OtpTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OtpTimerCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BlocBuilder<OtpTimerCubit, OtpTimerState>(
        builder: (context, state) {
          String timerText = '';
          bool isExpired = false;

          if (state is OtpTimerTick) {
            isExpired = state.isExpired;
            if (!state.isExpired) {
              timerText =
                  "00:${state.remainingSeconds.toString().padLeft(2, '0')} Sec";
            } else {
              timerText = "انتهى الوقت";
            }
          } else {
            timerText = "00:59 Sec";
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Timer Text
              Text(
                timerText,
                style: Styles.textStyle10.copyWith(color: kGreyTextColor),
              ),

              /// Resend Text
              HaveAccountText(
                normalText: "لم يصلك رمز؟ ",
                actionText: "إعادة إرسال",
                isEnabled: isExpired,
                onTap: isExpired
                    ? () {
                        cubit.resendCode();
                      }
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
