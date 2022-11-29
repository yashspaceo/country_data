
import 'package:country_data/data/local/database/entity/country_code.dart';

import 'database.dart';

/// Database manager to store and retrieve data from local database
class DatabaseManager {
  static final DatabaseManager _instance = DatabaseManager._internal();

  factory DatabaseManager() {
    return _instance;
  }

  DatabaseManager._internal();

  late AppDatabase _appDatabase;

  /// Initialize database
  init() async {
    _appDatabase = await $FloorAppDatabase.databaseBuilder('app_database.db').build(); //todo apply your database name here
    return _appDatabase;
  }

  /// Add country data into country data table
  void addCountryData(CountryData countryData) {
    final countryDataDao = _appDatabase.countryDataDao;
    countryDataDao.insertCountryData(countryData);
  }

  /// Add All country data into country data table
  Future<void> addAllCountryData(List<CountryData> countryData) {
    final countryDataDao = _appDatabase.countryDataDao;
    return countryDataDao.insertAllCountryData(countryData);
  }

  /// Get all country data list stored into country data table
  Future<List<CountryData>> getAllCountryData() {
    return _appDatabase.countryDataDao.findAllCountryData();
  }

  /// Get all country data list stored into country data table
  Future<List<CountryData>> getSearchCountryData(String countryDataName) {
    return _appDatabase.countryDataDao.findSearchCountryData(countryDataName);
  }

  /// Remove country data item from country data table
  Future<void> removeCountryDataById(int countryDataId) {
    return _appDatabase.countryDataDao.deleteCountryDataById(countryDataId);
  }

  /// Remove all Country Data from table
  Future<void> removeAllCountryData() {
    return _appDatabase.countryDataDao.deleteAllCountryData();
  }
}
