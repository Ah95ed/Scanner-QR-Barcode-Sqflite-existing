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
  // DataBaseHelper._privateConstructor();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else if (Platform.isWindows || Platform.isLinux) {
      return null;
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
  Future<int?> insert(
    String name,
    String barcode,
    String cost,
    String sell,
  ) async {
    Database? db = await database;
    return await db!.rawInsert(
        'INSERT INTO $TableName ($Name, $BarCode,$Cost,$Sell) VALUES($name, $barcode,$cost,$sell)');
  }

//SelectAll
  Future<List<Map<String, dynamic>?>?> getAllUser(
      String skip, String limit) async {
    Database? db = await database;
    var result = await db!.rawQuery(
        'SELECT * FROM $TableName  WHERE ID > $skip ORDER BY ID LIMIT $limit');

    return result.toList();
  }

  static Future<List> searchBar(String name) async {
    Database? db = await DataBaseHelper.initDataBase();
    return db.query(TableName, where: Name, whereArgs: [name]);
  }

  static Future update(
    String Table,
    String Column,
    String valus,
    String id,
  ) async {
    final db = await DataBaseHelper.initDataBase();
    return await db.update(Table, {Column: valus},
        where: 'ID = ?', whereArgs: [id]);
  }



  // delete
  Future<Future<int>?> delete(String id) async {
    Database? db = await database;
    return db?.rawDelete(
      'DELETE FROM Ahmed WHERE id = ?',
      [id],
    );
  }

  Future<List<Map<String, dynamic>>> searchInDatabase(String query) async {
    Database? db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      TableName,
      where: '$Name LIKE ?',
      whereArgs: ['%$query%'],
    );
    return results;
  }

  Future<List<Map<String, dynamic>>> searchBarCode(String barCode) async {
    Database? db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      TableName,
      where: '$BarCode LIKE ?',
      whereArgs: ['%$barCode%'],
    );
    return results;
  }

  Future<List<Map<String, dynamic>>> searchBarCodeOrder(String barCode) async {
    Database? db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      TableName,
      where: '$BarCode LIKE ?',
      whereArgs: ['%$barCode%'],
    );
    return results;
  }

  Future<int?> addData(
      String name, String barcode, String cost, String sell) async {
    Database? db = await database;

    return await db!.insert(
      TableName,
      {
        Name: name,
        BarCode: barcode,
        Cost: cost,
        Sell: sell,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
