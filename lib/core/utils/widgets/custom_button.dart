import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.btnText,
    this.color,
    this.txtColor,
    this.txtStyle,
    this.borderColor,
    this.hasIcon,
    this.iconWidget,
  });
  final Function()? onPressed;
  final String btnText;
  final Color? color;
  final Color? txtColor;
  final TextStyle? txtStyle;
  final Color? borderColor;
  final bool? hasIcon;
  final Widget? iconWidget;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: color ?? kPrimaryColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hasIcon == true
                ? iconWidget ?? Icon(Icons.arrow_forward_rounded)
                : const SizedBox(),
            hasIcon == true ? const SizedBox(width: 10) : const SizedBox(),
            Text(
              btnText,
              style:
                  txtStyle ??
                  TextStyle(
                    color: txtColor ?? Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
