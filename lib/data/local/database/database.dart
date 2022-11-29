// required package imports
// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dao/user_dao.dart';
import 'entity/country_code.dart';
part 'database.g.dart'; // the generated code will be there


@Database(version: 1, entities: [CountryData])
abstract class AppDatabase extends FloorDatabase {
  CountryDataDao get countryDataDao;
}