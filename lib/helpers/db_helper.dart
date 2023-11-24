import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  static final _databaseName = "ldp_fyp.db";
  static final _databaseVersion = 1;
  static const orderByAsc = 'ASC';
  static const orderByDesc = 'DESC';

  static final tblUser = 'users';
  static final userId = 'id';
  static final userName = 'username';
  static final userEmail = 'email';
  static final userPassword = 'password';

  static final tblPrediction = 'predictions';
  static final predictionId = 'id';
  static final predictionName = 'name';
  static final predictionAge = 'age';
  static final predictionOccupationId = 'occupationId';
  static final predictionAnnualIncome = 'annualIncome';
  static final predictionMonthlyInHandSalary = 'monthlyInHandSalary';
  static final predictionUserId = 'userId';
  static final predictionDate = 'date';
  static final predictionScore = 'score';

  static final tblAgeRange = 'agerange';
  static final ageRangeId = 'id';
  static final ageRangeStart = 'start';
  static final ageRangeEnd = 'end';
  static final ageRangeScore = 'score';

  static final tblOccupation = 'occupations';
  static final occupationId = 'id';
  static final occupationName = 'name';
  static final occupationScore = 'score';

  static final tblAnnualIncomeRange = 'annualincomerange';
  static final annualIncomeRangeId = 'id';
  static final annualIncomeRangeStart = 'start';
  static final annualIncomeRangeEnd = 'end';
  static final annualIncomeRangeScore = 'score';

  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, _databaseName),
      onCreate: _onCreate,
      version: _databaseVersion,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tblUser (
            $userId TEXT PRIMARY KEY,
            $userName TEXT NOT NULL,
            $userEmail TEXT,
            $userPassword TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE $tblPrediction (
            $predictionId INTEGER PRIMARY KEY AUTOINCREMENT,
            $predictionName TEXT,
            $predictionAge INTEGER,
            $predictionOccupationId INTEGER,
            $predictionAnnualIncome NUMERIC,
            $predictionMonthlyInHandSalary NUMERIC
            $predictionUserId TEXT
            $predictionDate DATE
            $predictionScore NUMERIC
          )
          ''');
    await db.execute('''
          CREATE TABLE $tblAgeRange (
            $ageRangeId INTEGER PRIMARY KEY,
            $ageRangeStart INTEGER,
            $ageRangeEnd INTEGER,
            $ageRangeScore NUMERIC
          )
          ''');

    await db.insert(tblAgeRange, {
      ageRangeId: 1,
      ageRangeStart: 10,
      ageRangeEnd: 20,
      ageRangeScore: 90,
    });

    await db.insert(tblAgeRange, {
      ageRangeId: 2,
      ageRangeStart: 20,
      ageRangeEnd: 30,
      ageRangeScore: 50,
    });

    await db.insert(tblAgeRange, {
      ageRangeId: 3,
      ageRangeStart: 30,
      ageRangeEnd: 40,
      ageRangeScore: 20,
    });

    await db.insert(tblAgeRange, {
      ageRangeId: 4,
      ageRangeStart: 40,
      ageRangeEnd: 60,
      ageRangeScore: 15,
    });

    await db.insert(tblAgeRange, {
      ageRangeId: 5,
      ageRangeStart: 60,
      ageRangeEnd: null,
      ageRangeScore: 40,
    });

    await db.execute('''
          CREATE TABLE $tblOccupation (
            $occupationId INTEGER PRIMARY KEY,
            $occupationName INTEGER,
            $ageRangeScore NUMERIC
          )
          ''');

    await db.insert(tblOccupation, {
      occupationId: 1,
      occupationName: 'Student',
      occupationScore: 90,
    });

    await db.insert(tblOccupation, {
      occupationId: 2,
      occupationName: 'Bussinesmen',
      occupationScore: 20,
    });

    await db.insert(tblOccupation, {
      occupationId: 3,
      occupationName: 'Government Officer',
      occupationScore: 15,
    });

    await db.execute('''
          CREATE TABLE $tblAnnualIncomeRange (
            $annualIncomeRangeId INTEGER PRIMARY KEY,
            $annualIncomeRangeStart INTEGER,
            $annualIncomeRangeEnd INTEGER,
            $annualIncomeRangeScore NUMERIC
          )
          ''');

    await db.insert(tblAnnualIncomeRange, {
      annualIncomeRangeId: 1,
      annualIncomeRangeStart: 10,
      annualIncomeRangeEnd: 30,
      annualIncomeRangeScore: 40,
    });

    await db.insert(tblAnnualIncomeRange, {
      annualIncomeRangeId: 2,
      annualIncomeRangeStart: 30,
      annualIncomeRangeEnd: 60,
      annualIncomeRangeScore: 30,
    });

    await db.insert(tblAnnualIncomeRange, {
      annualIncomeRangeId: 3,
      annualIncomeRangeStart: 60,
      annualIncomeRangeEnd: 100,
      annualIncomeRangeScore: 20,
    });

    await db.insert(tblAnnualIncomeRange, {
      annualIncomeRangeId: 4,
      annualIncomeRangeStart: 100,
      annualIncomeRangeScore: 10,
    });
  }

  Future<int> insert(String table, Map<String, Object> data) async {
    final db = await instance.database;
    return db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await instance.database;
    return db.query(table);
  }
}
