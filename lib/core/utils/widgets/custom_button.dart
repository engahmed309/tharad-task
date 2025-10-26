import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.btnText,
    this.color,
    this.gradientColors,
    this.txtColor,
    this.txtStyle,
    this.borderColor,
    this.hasIcon,
    this.iconWidget,
    this.width,
  });

  final Function()? onPressed;
  final String btnText;
  final Color? color;
  final List<Color>? gradientColors; // ✅ أضفنا خاصية جديدة
  final Color? txtColor;
  final TextStyle? txtStyle;
  final Color? borderColor;
  final bool? hasIcon;
  final Widget? iconWidget;
  final double? width;
  @override
  Widget build(BuildContext context) {
    final bool useGradient =
        gradientColors != null && gradientColors!.length >= 2;

    return SizedBox(
      width: double.infinity,
      height: 55,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: useGradient
                ? LinearGradient(colors: gradientColors!)
                : null,
            color: useGradient ? null : (color ?? kPrimaryColor),
          ),
          child: Container(
            width: width,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (hasIcon == true)
                  iconWidget ??
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                      ),
                if (hasIcon == true) const SizedBox(width: 10),
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
        ),
      ),
    );
  }
}
