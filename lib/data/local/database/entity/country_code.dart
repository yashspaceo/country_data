import 'package:floor/floor.dart';

@entity
class CountryData {
  @PrimaryKey(autoGenerate: true)
  int? id;

  final String? name;
  final String? currency;
  final String? flag;
  final String? dialCode;

  CountryData({
    this.id,
    required this.name,
    required this.currency,
    required this.flag,
    required this.dialCode,
  });
}
