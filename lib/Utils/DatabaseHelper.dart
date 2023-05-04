import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbName = 'notes.db';
  static final _dbversion = 1;
  static final _tableName = 'entries';

  static final columnId = '_id';
  static final columnDate = 'date';
  static final columnHeading = 'heading';
  static final columnContent = 'content';
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _initiateCreation();

  _initiateCreation() async {
    Directory directory = await getApplicationSupportDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path,
        version: _dbversion, onCreate: _createDatabase);
  }

  Future _createDatabase(Database db, int version) async {
    return db.execute('''
      CREATE TABLE $_tableName(
      $columnId INTEGER PRIMARY KEY,
      $columnDate TEXT NOT NULL,
      $columnHeading TEXT NOT NULL,
      $columnContent TEXT NOT NULL)
      ''');
  }

  Future<int> insert(row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName, orderBy: "date DESC");
  }

  Future update(row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db
        .update(_tableName, row, where: '$columnId= ?', whereArgs: [id]);
  }

  Future delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$columnId= ?', whereArgs: [id]);
  }
}
