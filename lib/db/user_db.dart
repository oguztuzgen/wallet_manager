import 'package:wallet_manager/model/category.dart';
import 'package:wallet_manager/model/wallet_manager_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

final String tableName = 'users';
final String tableNameCategories = 'categories';
final String columnDBid = 'id';
final String columnUID = 'uid';
final String columnCategoriesID = 'categoriesid';
final String columnExpenseID = 'expenseid';
final String columnCategory = 'category';

class UserDB {
  static UserDB _userDB;
  static Database _database; // * Singleton db

  UserDB._createInstance();
  factory UserDB() {
    if (_userDB == null) {
      _userDB = UserDB._createInstance();
    }
    return _userDB;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
     return await openDatabase(

      join(await getDatabasesPath(), 'wallet_manager.db'),
      onCreate: (db, version) async {
        createTables(db);
      },
         onOpen: createTables,

      version: 1
    );
  }

  Future<void> createTables(Database db) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $tableNameCategories (
          $columnDBid INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnCategory TEXT NOT NULL);
          ''');

    await db.execute('''
          CREATE TABLE IF NOT EXISTS $tableName (
          $columnDBid INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnUID TEXT NOT NULL,
          $columnCategoriesID INTEGER,
          $columnExpenseID INTEGER);
        ''');
  }

  Future<int> insertUser(ExpenseTrackerUser user) async {
    final Database db = await this.database;

    var response = await db.insert(
      tableName,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print(response);
    return response;
  }

  Future<dynamic> getUser(String uid) async {
    final Database db = await database;

    var response = await db.query('users');

    if (response.length == 0) {
      print("Returning null");
      return null;
    } else {
      var resMap = response[0];
      print("Returning result\n$resMap");
      return resMap.isNotEmpty ? resMap : null;
    }
  }

  Future<int> insertCategory(String category) async {
    final Database db = await this.database;

    var response = await db.insert(
      tableNameCategories,
      { category: category },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print(response);
    return response;
  }

  Future<List<WMCategory>> getCategories() async {
    final Database db = await database;

    final List<Map<String, dynamic>> response = await db.query(tableNameCategories);

    return List.generate(
        response.length, (i) {
          return WMCategory(dbID: response[i]['id'], category: response[i]['category'],);
        }
    );
  }
}