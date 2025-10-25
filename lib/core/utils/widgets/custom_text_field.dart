import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.hint,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.enabled = true,
    this.minLines = 1,
    this.maxLines = 1,
    this.fillColor,
    this.borderColor = kPrimaryColor,
    this.radius = 12,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 12,
    ),
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isPassword;
  final String? Function(String? value)? validator;
  final void Function(String value)? onChanged;
  final void Function(String value)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final int minLines;
  final int maxLines;
  final Color? fillColor;
  final Color borderColor;
  final double radius;
  final EdgeInsets contentPadding;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscure;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outline = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.radius),
      borderSide: BorderSide(color: widget.borderColor, width: 1),
    );

    final greyOutline = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.radius),
      borderSide: BorderSide(
        color: widget.borderColor.withOpacity(.35),
        width: 1,
      ),
    );

    return TextFormField(
      cursorColor: kPrimaryColor,
      controller: widget.controller,
      focusNode: _focusNode,
      obscureText: _obscure,
      enabled: widget.enabled,
      minLines: widget.minLines,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,

      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: (v) {
        //  Form.of(context).validate(); // يتحقق عند انتهاء الإدخال فقط
        // widget.onFieldSubmitted?.call(v);
      },
      decoration: InputDecoration(
        isDense: true,
        filled: widget.fillColor != null,
        fillColor: widget.fillColor,
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: kGreyBgColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.33,
        ),
        contentPadding: widget.contentPadding,
        enabledBorder: greyOutline,
        focusedBorder: outline,
        errorBorder: outline.copyWith(
          borderSide: BorderSide(color: Colors.red.shade600, width: 1),
        ),
        focusedErrorBorder: outline.copyWith(
          borderSide: BorderSide(color: Colors.red.shade600, width: 1.2),
        ),
        prefixIcon:
            widget.prefix ??
            (widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: widget.borderColor)
                : null),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: widget.borderColor,
                ),
              )
            : widget.suffix ??
                  (widget.suffixIcon != null
                      ? Icon(widget.suffixIcon, color: widget.borderColor)
                      : null),
      ),
      style: const TextStyle(fontWeight: FontWeight.w500),
    );
  }
}
