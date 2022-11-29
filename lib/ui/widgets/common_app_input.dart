import 'package:country_data/app/app_colors.dart';
import 'package:country_data/app/app_font_weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Common app input used in whole app
class CommonAppInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool isPassword;
  final double borderRadius;
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixClick;
  final IconData? prefixIcon;
  final VoidCallback? onPrefixClick;
  final TextInputAction textInputAction;
  final Function(String text)? onSubmitted;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final RegExp? regExp;
  final RegExp? blackListRegExp;
  final int? maxLength;

  const CommonAppInput({
    Key? key,
    required this.textEditingController,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.borderRadius = 0,
    this.hintText = '',
    this.hintStyle,
    this.labelStyle,
    this.suffixIcon,
    this.onSuffixClick,
    this.prefixIcon,
    this.onPrefixClick,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
    this.focusNode,
    this.nextFocusNode,
    this.regExp,
    this.blackListRegExp,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      focusNode: focusNode,
      controller: textEditingController,
      keyboardType: textInputType,
      obscureText: isPassword,
      textInputAction: textInputAction,
      onFieldSubmitted: (String text) {
        onSubmitted?.call(text);
        nextFocusNode?.requestFocus();
      },
      inputFormatters: <TextInputFormatter>[
        if (regExp != null) FilteringTextInputFormatter.allow(regExp!),
        if (blackListRegExp != null) FilteringTextInputFormatter.deny(blackListRegExp!),
      ],
      decoration: InputDecoration(
        counter: const Offstage(),
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: InkResponse(
                  radius: 15,
                  onTap: onPrefixClick,
                  child: Icon(
                    prefixIcon,
                    size: 18,
                    color: AppColors.primaryPalette,
                  ),
                ),
              )
            : null,
        suffixIconConstraints: BoxConstraints(maxWidth: 24.w, maxHeight: 24.w),
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: InkResponse(
                  radius: 15,
                  onTap: onSuffixClick,
                  child: Icon(
                    suffixIcon,
                    size: 18,
                    color: AppColors.primaryPalette,
                  ),
                ),
              )
            : null,
        hintText: hintText,
        isDense: true,
        labelStyle: labelStyle ??
            GoogleFonts.poppins(fontSize: 14, color: AppColors.colorBlack, fontWeight: AppFontWeight.regular),
        hintStyle: hintStyle ??
            GoogleFonts.poppins(fontSize: 14, color: AppColors.colorCBCBCB, fontWeight: AppFontWeight.regular),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.5.w, vertical: 11.5.h),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.colorCBCBCB,
            style: BorderStyle.solid,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
