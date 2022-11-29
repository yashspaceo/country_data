import 'dart:developer';
import 'package:country_data/app/app_colors.dart';
import 'package:country_data/app/app_font_weight.dart';
import 'package:country_data/app/app_images.dart';
import 'package:country_data/app/app_routes.dart';
import 'package:country_data/data/local/database/entity/country_code.dart';
import 'package:country_data/ui/widgets/common_app_button.dart';
import 'package:country_data/ui/widgets/common_app_shimmer.dart';
import 'package:country_data/ui/widgets/common_app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Obx(() => controller.searchBoolean.value ? const Text("Country Data") : searchTextField()),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 12),
              child: Row(
                children: [
                  GestureDetector(
                      child: Obx(
                          () => controller.searchBoolean.value ? const Icon(Icons.search) : const Icon(Icons.clear)),
                      onTap: () {
                        controller.searchBoolean.value = !controller.searchBoolean.value;
                        controller.searchController.clear();
                        controller.searchBoolean.value
                            ? controller.countryDataList.assignAll(controller.countryMainDataList)
                            : const Offstage();
                      }),
                  const SizedBox(width: 10),
                  GestureDetector(
                    child: const Icon(Icons.filter_alt),
                    onTap: () {
                      showFilterDialog(context);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
        drawer: const Drawer(),
        backgroundColor: AppColors.colorBlueLight,
        body: Obx(
          () => controller.isLoading.isTrue
              ? getShimmerView()
              : controller.countryDataList.isEmpty
                  ? getNoDataFoundDialog()
                  : getDashboardPageView(),
        ),
      ),
    );
  }

  ///[showFilterDialog] to show filter dialog box
  Future showFilterDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter'),
          content: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => RadioListTile(
                  title: const Text("By Name"),
                  activeColor: AppColors.primaryPalette,
                  value: "By Name",
                  groupValue: controller.filter.value,
                  onChanged: (value) {
                    controller.filter.value = value.toString();
                  },
                ),
              ),
              Obx(
                () => RadioListTile(
                  title: const Text("By Currency"),
                  activeColor: AppColors.primaryPalette,
                  value: "By Currency",
                  groupValue: controller.filter.value,
                  onChanged: (value) {
                    controller.filter.value = value.toString();
                  },
                ),
              ),
              const SizedBox(height: 20),
              CommonAppButton(
                text: "Apply",
                onClick: () {
                  Get.back();
                  log(controller.filter.value);
                  if (controller.filter.value == "By Name") {
                    controller.countryDataList.sort((a, b) => a.name.toString().compareTo(b.name.toString()));
                  } else if (controller.filter.value == "By Currency") {
                    controller.countryDataList.sort((a, b) => a.currency.toString().compareTo(b.currency.toString()));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  ///[getNoDataFoundDialog] is used to show no data found
  Widget getNoDataFoundDialog() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      alignment: Alignment.topCenter,
      child: Text(
        'No Data Found',
        style: TextStyle(fontWeight: AppFontWeight.medium, fontSize: 16),
      ),
    );
  }

  ///[getShimmerView] to show shimmer view in dashboard page
  Widget getShimmerView() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          color: AppColors.colorWhite,
          child: CommonAppShimmer.rectangular(
              height: 100, shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ).paddingOnly(top: index == 0 ? 4 : 0);
      },
    );
  }

  ///[searchTextField] Search text field
  Widget searchTextField() {
    return TextField(
      controller: controller.searchController,
      onChanged: (value) {
        log("Searching Value -> $value");
        controller.getSearchDataList(value);
      },

      autofocus: true,
      //Display the keyboard when TextField is displayed
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      //Specify the action button on the keyboard
      decoration: const InputDecoration(
        //Style of TextField
        enabledBorder: UnderlineInputBorder(
            //Default TextField border
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: UnderlineInputBorder(
            //Borders when a TextField is in focus
            borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search', //Text that is displayed when nothing is entered.
        hintStyle: TextStyle(
          //Style of hintText
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }

  ///[getDashboardPageView] Create page view with all pages
  Widget getDashboardPageView() {
    return Obx(
      () => ListView.builder(
        itemBuilder: (_, index) {
          return getCardView(index)
              .paddingOnly(top: index == 0 ? 4 : 0, bottom: index == controller.countryDataList.length - 1 ? 4 : 0);
        },
        itemCount: controller.countryDataList.length,
      ),
    );
  }

  ///[getCardView] Create card view with all card
  Widget getCardView(int index) {
    return GestureDetector(
      onLongPress: () {
        getDialogBox(controller.countryDataList[index]);
        debugPrint("long press clicked");
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  log("Image Click");
                  if (controller.countryDataList[index].flag != null && controller.countryDataList[index].flag != "") {
                    controller.selectImage.value = controller.countryDataList[index].flag ?? '';
                    Get.toNamed(AppRoutes.imagePage);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CommonAppImage(
                      imagePath: controller.countryDataList[index].flag ?? AppImages.icSplash,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
                child: VerticalDivider(
                  width: 10,
                  color: AppColors.colorBlack,
                  thickness: 1.2,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${controller.countryDataList[index].name}",
                        style: TextStyle(fontSize: 20, fontWeight: AppFontWeight.bold, color: AppColors.colorBlack),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Currency :- ${controller.countryDataList[index].currency}",
                        style: TextStyle(fontSize: 14, fontWeight: AppFontWeight.medium, color: AppColors.colorBlack),
                      ),
                      Text(
                        "DialCode :- ${controller.countryDataList[index].dialCode}",
                        style: TextStyle(fontSize: 14, fontWeight: AppFontWeight.medium, color: AppColors.colorBlack),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///[getDialogBox] to show conformation popup dialog
  Future getDialogBox(CountryData element) {
    return Get.defaultDialog(
      title: "Confirmation",
      middleText: "Are you sure want to Remove?",
      textConfirm: "Yes",
      textCancel: "No",
      buttonColor: AppColors.colorBlue,
      cancelTextColor: AppColors.colorBlue,
      confirmTextColor: AppColors.colorWhite,
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        controller.deleteData(element);
        Get.back();
      },
    );
  }
}
