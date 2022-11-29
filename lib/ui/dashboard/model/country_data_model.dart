class CountryDataModel {
  bool? error;
  String? msg;
  List<Data>? data;

  CountryDataModel({this.error, this.msg, this.data});

  CountryDataModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  String? currency;
  String? unicodeFlag;
  String? flag;
  String? dialCode;

  Data({this.name, this.currency, this.unicodeFlag, this.flag, this.dialCode});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    currency = json['currency'];
    unicodeFlag = json['unicodeFlag'];
    flag = json['flag'];
    dialCode = json['dialCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['currency'] = currency;
    data['unicodeFlag'] = unicodeFlag;
    data['flag'] = flag;
    data['dialCode'] = dialCode;
    return data;
  }
}
