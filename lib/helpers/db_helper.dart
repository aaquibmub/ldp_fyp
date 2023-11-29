import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  static final _databaseName = "ldp_fyp_2.db";
  static final _databaseVersion = 1;
  static const orderByAsc = 'ASC';
  static const orderByDesc = 'DESC';

  static final tblUser = 'users';
  static final userId = 'id';
  static final userName = 'username';
  static final userEmail = 'email';
  static final userPassword = 'password';

  static final tblPrediction = 'predictions';
  // Personal Info
  static final predictionId = 'id';
  static final predictionName = 'name';
  static final predictionAge = 'age';
  static final predictionOccupationId = 'occupationId';
  static final predictionAnnualIncome = 'annualIncome';
  static final predictionMonthlyInHandSalary = 'monthlyInHandSalary';
  // bank details
  static final predictionNumOfBankAccounts = 'numOfBankAccounts';
  static final predictionNumOfCreditCards = 'numOfCreditCards';
  static final predictionIntrestRate = 'intrestRate';
  static final predictionNumOfLoans = 'numOfLoans';
  static final predictionDelayFormDueDate = 'delayFormDueDate';
// other details
  static final predictionNumberofDelayedPayment = 'numberOfDelayedPayment';
  static final predictionChangedCreditLimit = 'changedCreditLimit';
  static final predictionNumberofCreditInquiries = 'numberofCreditInquiries';
  static final predictionCreditMix = 'creditMix';
  static final predictionCreditUtilizationRatio = 'creditUtilizationRatio';
  static final predictionCreditHistoryAge = 'creditHistoryAge';
  static final predictionMonthlyBalance = 'monthlyBalance';

  static final predictionUserId = 'userId';
  static final predictionDate = 'date';
  static final predictionScore = 'score';

  static final tblOccupation = 'occupations';
  static final occupationId = 'id';
  static final occupationName = 'name';

  static final tblAnnualIncomeRange = 'annualincomerange';
  static final annualIncomeRangeId = 'id';
  static final annualIncomeRangeStart = 'start';
  static final annualIncomeRangeEnd = 'end';

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
    // tblUsers
    await db.execute('''
          CREATE TABLE $tblUser (
            $userId TEXT PRIMARY KEY,
            $userName TEXT NOT NULL,
            $userEmail TEXT,
            $userPassword TEXT
          )
          ''');

    // tblPredictions
    await db.execute('''
          CREATE TABLE $tblPrediction (
            $predictionId INTEGER PRIMARY KEY AUTOINCREMENT,
            $predictionName TEXT,
            $predictionAge INTEGER,
            $predictionOccupationId INTEGER,
            $predictionAnnualIncome NUMERIC,
            $predictionMonthlyInHandSalary NUMERIC,
            $predictionUserId TEXT,
            $predictionDate DATE,
            $predictionScore NUMERIC,
            $predictionNumOfBankAccounts INTEGER,
            $predictionNumOfCreditCards INTEGER,
            $predictionIntrestRate NUMERIC,
            $predictionNumOfLoans INTEGER,
            $predictionDelayFormDueDate INTEGER,
            $predictionNumberofDelayedPayment INTEGER,
            $predictionChangedCreditLimit NUMERIC,
            $predictionNumberofCreditInquiries INTEGER,
            $predictionCreditMix INTEGER,
            $predictionCreditUtilizationRatio NUMERIC,
            $predictionCreditHistoryAge INTEGER,
            $predictionMonthlyBalance NUMERIC
          )
          ''');

    await db.execute('''
          CREATE TABLE $tblOccupation (
            $occupationId INTEGER PRIMARY KEY,
            $occupationName INTEGER
          )
          ''');

    await db.insert(tblOccupation, {
      occupationId: 1,
      occupationName: 'Scientist',
    });

    await db.insert(tblOccupation, {
      occupationId: 2,
      occupationName: 'Teacher',
    });

    await db.insert(tblOccupation, {
      occupationId: 3,
      occupationName: 'Engineer',
    });

    await db.insert(tblOccupation, {
      occupationId: 4,
      occupationName: 'Entrepreneur',
    });

    await db.insert(tblOccupation, {
      occupationId: 5,
      occupationName: 'Developer',
    });

    await db.insert(tblOccupation, {
      occupationId: 6,
      occupationName: 'Lawyer',
    });

    await db.insert(tblOccupation, {
      occupationId: 7,
      occupationName: 'Media-Manager',
    });

    await db.insert(tblOccupation, {
      occupationId: 8,
      occupationName: 'Doctor',
    });

    await db.insert(tblOccupation, {
      occupationId: 9,
      occupationName: 'Journalist',
    });

    await db.insert(tblOccupation, {
      occupationId: 10,
      occupationName: 'Manager',
    });

    await db.insert(tblOccupation, {
      occupationId: 11,
      occupationName: 'Accountant',
    });

    await db.insert(tblOccupation, {
      occupationId: 12,
      occupationName: 'Musician',
    });

    await db.insert(tblOccupation, {
      occupationId: 13,
      occupationName: 'Mechanic',
    });

    await db.insert(tblOccupation, {
      occupationId: 14,
      occupationName: 'Writer',
    });

    await db.insert(tblOccupation, {
      occupationId: 15,
      occupationName: 'Architect',
    });

    await db.execute('''
          CREATE TABLE $tblAnnualIncomeRange (
            $annualIncomeRangeId INTEGER PRIMARY KEY,
            $annualIncomeRangeStart INTEGER,
            $annualIncomeRangeEnd INTEGER
          )
          ''');

    await db.insert(tblAnnualIncomeRange, {
      annualIncomeRangeId: 1,
      annualIncomeRangeStart: 10,
      annualIncomeRangeEnd: 30,
    });

    await db.insert(tblAnnualIncomeRange, {
      annualIncomeRangeId: 2,
      annualIncomeRangeStart: 30,
      annualIncomeRangeEnd: 60,
    });

    await db.insert(tblAnnualIncomeRange, {
      annualIncomeRangeId: 3,
      annualIncomeRangeStart: 60,
      annualIncomeRangeEnd: 100,
    });

    await db.insert(tblAnnualIncomeRange, {
      annualIncomeRangeId: 4,
      annualIncomeRangeStart: 100,
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

  Future<int> update(
    String table,
    Map<String, Object> data,
    int id,
  ) async {
    final db = await instance.database;
    return db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await instance.database;
    return db.query(table);
  }

  Future<Map<String, dynamic>> getFirstOrDefault(String table, int id) async {
    final db = await instance.database;
    return (await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    ))
        .first;
  }
}
