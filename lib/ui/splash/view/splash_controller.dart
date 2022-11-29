import 'dart:developer';
import 'package:country_data/app/app_class.dart';
import 'package:country_data/app/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    AppClass().removeSplash();

    Future.delayed(const Duration(seconds: 2)).then((value) {
      log('after 2 second');
      Get.offAllNamed(AppRoutes.dashboardPage); // Check if user already logged in
    }); // Get logged in user data
    // checkAppVersion();
  }
}
