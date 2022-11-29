import 'package:country_data/app/app_colors.dart';
import 'package:country_data/app/app_font_weight.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Common app bar used in whole app
class CommonAppBar extends AppBar {
  final String titleText;

  CommonAppBar({
    Key? key,
    this.titleText = '',
  }) : super(key: key);

  @override
  Widget? get title => Text(
        titleText,
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: AppColors.colorWhite,
          fontWeight: AppFontWeight.semiBold,
        ),
      );
}
