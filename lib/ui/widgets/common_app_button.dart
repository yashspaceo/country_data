import 'package:country_data/app/app_colors.dart';
import 'package:country_data/app/app_font_weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Common app button used in whole app
class CommonAppButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final double? margin;
  final double? width;

  const CommonAppButton({
    Key? key,
    required this.text,
    required this.onClick,
    this.margin,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primaryPalette,
          boxShadow: const [
            BoxShadow(
              color: AppColors.colorShadow,
              offset: Offset(
                0,
                3,
              ),
              blurRadius: 10,
              spreadRadius: 6,
            )
          ],
        ),
        height: 35.h,
        width: width ?? 75.w,
        margin: EdgeInsets.symmetric(vertical: margin ?? 0),
        alignment: Alignment.center,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: AppFontWeight.regular,
            color: AppColors.colorWhite,
          ),
        ),
      ),
    );
  }
}
