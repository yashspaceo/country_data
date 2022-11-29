// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  // ignore: library_private_types_in_public_api
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  // ignore: library_private_types_in_public_api
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CountryDataDao? _countryDataDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CountryData` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `currency` TEXT, `flag` TEXT, `dialCode` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CountryDataDao get countryDataDao {
    return _countryDataDaoInstance ??=
        _$CountryDataDao(database, changeListener);
  }
}

class _$CountryDataDao extends CountryDataDao {
  _$CountryDataDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _countryDataInsertionAdapter = InsertionAdapter(
            database,
            'CountryData',
            (CountryData item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'currency': item.currency,
                  'flag': item.flag,
                  'dialCode': item.dialCode
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CountryData> _countryDataInsertionAdapter;

  @override
  Future<List<CountryData>> findAllCountryData() async {
    return _queryAdapter.queryList('SELECT * FROM CountryData',
        mapper: (Map<String, Object?> row) => CountryData(
            id: row['id'] as int?,
            name: row['name'] as String?,
            currency: row['currency'] as String?,
            flag: row['flag'] as String?,
            dialCode: row['dialCode'] as String?));
  }

  @override
  Future<List<CountryData>> findSearchCountryData(
      String countryDataName) async {
    return _queryAdapter.queryList(
        'SELECT * FROM CountryData WHERE name LIKE "%"?1"%"',
        mapper: (Map<String, Object?> row) => CountryData(
            id: row['id'] as int?,
            name: row['name'] as String?,
            currency: row['currency'] as String?,
            flag: row['flag'] as String?,
            dialCode: row['dialCode'] as String?),
        arguments: [countryDataName]);
  }

  @override
  Future<void> deleteCountryDataById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM CountryData WHERE id=?1', arguments: [id]);
  }

  @override
  Future<void> deleteAllCountryData() async {
    await _queryAdapter.queryNoReturn('DELETE FROM CountryData');
  }

  @override
  Future<void> insertCountryData(CountryData countryData) async {
    await _countryDataInsertionAdapter.insert(
        countryData, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertAllCountryData(List<CountryData> countryData) async {
    await _countryDataInsertionAdapter.insertList(
        countryData, OnConflictStrategy.abort);
  }
}
