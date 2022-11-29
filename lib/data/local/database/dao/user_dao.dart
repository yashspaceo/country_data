import 'package:country_data/data/local/database/entity/country_code.dart';
import 'package:floor/floor.dart';

@dao
abstract class CountryDataDao {
  @Query('SELECT * FROM CountryData')
  Future<List<CountryData>> findAllCountryData();

  @Query('SELECT * FROM CountryData WHERE name LIKE "%":countryDataName"%"')
  Future<List<CountryData>> findSearchCountryData(String countryDataName);

  @insert
  Future<void> insertCountryData(CountryData countryData);

  @insert
  Future<void> insertAllCountryData(List<CountryData> countryData);

  @Query('DELETE FROM CountryData WHERE id=:id')
  Future<void> deleteCountryDataById(int id);

  @Query('DELETE FROM CountryData')
  Future<void> deleteAllCountryData();
}
