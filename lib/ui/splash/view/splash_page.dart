import 'package:country_data/app/app_colors.dart';
import 'package:country_data/app/app_images.dart';
import 'package:country_data/ui/splash/view/splash_controller.dart';
import 'package:country_data/ui/widgets/common_app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SplashPage extends GetView<SplashController> {
  @override
  SplashController controller = Get.put(SplashController());

  SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorBlueLight,
        body: Center(
          child: SizedBox(
            height: Get.height * 0.7,
            width: Get.width * 0.8,
            child: RotatedBox(
              quarterTurns: 1,
              child: CommonAppImage(
                imagePath: AppImages.icSplash,
                fit: BoxFit.cover,
                height: Get.height,
                width: Get.width,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
