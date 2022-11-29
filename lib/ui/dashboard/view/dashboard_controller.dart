import 'dart:convert';
import 'package:country_data/data/local/database/database_manager.dart';
import 'package:country_data/data/local/database/entity/country_code.dart';
import 'package:country_data/ui/dashboard/model/country_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:country_data/data/local/database/entity/country_code.dart' as local_user;

class DashboardController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<CountryData> countryDataList = <CountryData>[].obs;
  RxList<CountryData> countryMainDataList = <CountryData>[].obs;
  TextEditingController searchController = TextEditingController();
  RxBool searchBoolean = true.obs;
  RxString filter = "By Name".obs;
  RxString selectImage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProduct();
  }

  /// Fetch Product data from api
  void fetchProduct() async {
    isLoading.value = true;
    final response = await http.get(
        Uri.parse('https://countriesnow.space/api/v0.1/countries/info?returns=currency,flag,unicodeFlag,dialCode'));

    List<Data> list = [];
    if (response.statusCode == 200) {
      // list = (jsonDecode(response.body) as CountryDataModel).map<Data>((value) => Data.fromJson(value)).toList();
      CountryDataModel data = CountryDataModel.fromJson(jsonDecode(response.body));
      list = data.data ?? [];
    } else {
      throw Exception(
        'Failed to load CountryDataModel data..',
      );
    }

    await DatabaseManager().removeAllCountryData();
    await DatabaseManager().addAllCountryData(list
        .map((e) => local_user.CountryData(name: e.name, currency: e.currency, flag: e.flag, dialCode: e.dialCode))
        .toList());

    getDataList();
    isLoading.value = false;
  }

  /// [getUserList] is used to get list from local storage
  void getDataList() async {
    List<CountryData> data = await DatabaseManager().getAllCountryData();
    countryMainDataList.assignAll(data);

    countryDataList.assignAll(data);
    countryDataList.sort((a, b) => a.name.toString().compareTo(b.name.toString()));
  }

  ///[deleteData] is used to delete Data from local database
  void deleteData(CountryData item) {
    countryMainDataList.remove(item);
    countryDataList.remove(item);
    DatabaseManager().removeCountryDataById(item.id ?? 0);
  }

  ///[getSearchDataList] to get list after search
  void getSearchDataList(String value) {
    countryDataList.clear();
    if (value.trim().isNotEmpty) {
      for (var element in countryMainDataList) {
        if (element.dialCode != null) {
          if (element.name!.toLowerCase().contains(value.toLowerCase()) || element.dialCode!.contains(value)) {
            countryDataList.add(element);
            if (filter.value == "By Name") {
              countryDataList.sort((a, b) => a.name.toString().compareTo(b.name.toString()));
            } else if (filter.value == "By Currency") {
              countryDataList.sort((a, b) => a.currency.toString().compareTo(b.currency.toString()));
            }
          }
        } else {
          if (element.name!.toLowerCase().contains(value.toLowerCase())) {
            countryDataList.add(element);
            if (filter.value == "By Name") {
              countryDataList.sort((a, b) => a.name.toString().compareTo(b.name.toString()));
            } else if (filter.value == "By Currency") {
              countryDataList.sort((a, b) => a.currency.toString().compareTo(b.currency.toString()));
            }
          }
        }
      }
    } else if (value.trim().isEmpty) {
      countryDataList.assignAll(countryMainDataList);
    }
  }
}
