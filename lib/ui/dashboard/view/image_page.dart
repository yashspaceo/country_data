import 'package:country_data/app/app_colors.dart';
import 'package:country_data/ui/dashboard/view/dashboard_controller.dart';
import 'package:country_data/ui/widgets/common_app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_widget/zoom_widget.dart';

class ImagePage extends GetView<DashboardController> {
  const ImagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorBlack,
        title: const Text(""),
      ),
      backgroundColor: AppColors.colorBlueLightLight,
      body: Center(
        child: Zoom(
          backgroundColor: AppColors.colorBlack,
          maxZoomWidth: 200,
          maxZoomHeight: 250,
          child: CommonAppImage(
            imagePath: controller.selectImage.value,
            height: 300,
            width: 300,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
