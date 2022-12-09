import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static const dataBaseName = "pharmacy.db";
  static const version = 1;
  static const TableName = 'Ahmed';
  static const id = 'ID';
  static const Name = 'Name';
  static const BarCode = 'Barcode';
  static const Cost = 'Cost';
  static const Sell = 'Sell';
  DataBaseHelper._privateConstructor();
  static DataBaseHelper dataBaseHelper = DataBaseHelper._privateConstructor();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      return await initDataBase();
    }
  }

  static Future<Database> initDataBase() async {
    var datPath = await getDatabasesPath();
    String path = join(datPath, dataBaseName);
    if (!await databaseExists(path)) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      ByteData data = await rootBundle.load(join("assets", dataBaseName));

      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes);
    } else {
      // print("opening data first");
    }
    return await openDatabase(path, version: version);
  }

  //insert
  Future<int?> insert(String sql) async {
    Database? db = await database;
    return await db?.rawInsert(sql);
  }

//SelectAll
  static Future<List<Map<String, dynamic>?>?> getAllUser(
      String tableName) async {
    Database? db = await DataBaseHelper.initDataBase();
    var result = await db.query(tableName);
    // db.close();
    return result.toList();
  }

//   static Future<List<Map<String, dynamic>?>?>
//   getAllUser(String table) async {
//
//     final db = await DataBaseHelper.initDataBase();
//     return db.query(table);
//   }
  readData(String sql) async {
    Database? db = await database;
    List<Map> response = await db!.rawQuery(sql);
    // db.close();
    return response;
  }

  Future<List> searchBar() async {
    Database? db = await database;
    return db!.query(TableName);
  }

// counts
// Future<int?> getCount() async{
//   var db = await dataBaseHelper.database;
//   return Sqflite.firstIntValue(await db?.rawQuery('SELECT COUNT(ID) FROM $TableName'));
// }
// update
  upDate(String table, Map<String, Object?> values, String? myWhere) async {
    Database? db = await dataBaseHelper.database;
    int response = await db!.update(table, values, where: myWhere);
    // db.close();
    return response;
  }

  List<Map> Data() {
    Database db = dataBaseHelper.database as Database;
    List<Map>? response = db.rawQuery("SELECT * FROM ahmed") as List<Map>?;
    return response!;
  }

  // delete
  Future<Future<int>?> delete(String id) async {
    Database? db = await dataBaseHelper.database;
    return db?.delete(TableName, where: Name, whereArgs: [id]);
  }
}
