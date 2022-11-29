import 'package:country_data/app/app_colors.dart';
import 'package:country_data/app/app_font_weight.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonBottomSheet extends StatelessWidget {
  final String title;
  final String option1Text;
  final String option2Text;
  final VoidCallback onTapOption1;
  final VoidCallback onTapOption2;

  const CommonBottomSheet({
    Key? key,
    required this.title,
    required this.option1Text,
    required this.option2Text,
    required this.onTapOption1,
    required this.onTapOption2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primaryPalette,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: AppColors.colorWhite,
                  fontSize: 17,
                  fontWeight: AppFontWeight.bold,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onTapOption1,
            child: SizedBox(
              width: double.infinity,
              child: Text(
                option1Text,
                style: TextStyle(
                  color: AppColors.colorBlack,
                  fontSize: 17,
                  fontWeight: AppFontWeight.regular,
                ),
              ).paddingOnly(
                left: 15,
                top: 15,
                bottom: 8,
              ),
            ),
          ),
          InkWell(
            onTap: onTapOption2,
            child: SizedBox(
              width: double.infinity,
              child: Text(
                option2Text,
                style: TextStyle(
                  color: AppColors.colorBlack,
                  fontSize: 17,
                  fontWeight: AppFontWeight.regular,
                ),
              ).paddingOnly(
                left: 15,
                top: 8,
                bottom: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
