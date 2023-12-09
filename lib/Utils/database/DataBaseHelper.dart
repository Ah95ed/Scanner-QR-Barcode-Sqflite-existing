import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart' as sqfData;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';





bool isStoragePermission = true;
bool isVideosPermission = true;
bool isPhotosPermission = true;

// Only check for storage < Android 13
// DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
// AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
// if (androidInfo.version.sdkInt >= 33) {
//   isVideosPermission = await Permission.videos.status.isGranted;
//   isPhotosPermission = await Permission.photos.status.isGranted;
// } else {
//   isStoragePermission = await Permission.storage.status.isGranted;
// }

// if (isStoragePermission && isVideosPermission && isPhotosPermission) {
//   // no worries about crash 
// } else {
//   // write your code here
// }





class DataBaseHelper {
  static const dataBaseName = "pharmacy.db";
  static const version = 3;
  static const TableName = 'Ahmed';
  static const id = 'ID';
  static const Name = 'Name';
  static const BarCode = 'Barcode';
  static const Cost = 'Cost';
  static const Sell = 'Sell';

 Database? _database;

  Future<sqfData.Database?> get database async {
    if (_database != null) {
      return _database;
    } else if (Platform.isWindows || Platform.isLinux) {
      return await initDataBaseWin();
    } else {
      return await initDataBase();
    }
  }

  Future<Database?> initDataBaseWin() async {
    sqfliteFfiInit();

    databaseFactory = databaseFactoryFfi;
    final databasePath = await databaseFactory.getDatabasesPath();
    final path = join(databasePath, dataBaseName);
    // Replace with your desired database name

    if (!await databaseFactory.databaseExists(path)) {
      try {
        await Directory(dirname(path)).create(
          recursive: true,
        );
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      ByteData data = await rootBundle.load(join(
        'assets/$dataBaseName',
      ));

      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      await File(path).writeAsBytes(
        bytes,
        flush: true,
      );
    } else {
      return await databaseFactory.openDatabase(path);
    }

    return await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: version,
        onCreate: (db, version) {
          db.transaction((reference) async {
            await reference.execute('''
        CREATE TABLE IF NOT EXISTS $TableName (
          $id INTEGER PRIMARY KEY AUTOINCREMENT,
          $Name TEXT,
          $BarCode TEXT,
          $Cost TEXT,
          $Sell TEXT
        )
      ''');
          });
        },
      ),
    );
  }

  Future<sqfData.Database> initDataBase() async {
    var datPath = await sqfData.getDatabasesPath();

    String path = join(
      datPath,
      dataBaseName,
    );
    if (!await sqfData.databaseExists(path)) {
      try {
        await Directory(dirname(path)).create(
          recursive: true,
        );
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      ByteData data = await rootBundle.load(
        join(
          "assets/$dataBaseName",
        ),
      );

      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      log('message');

      await File(path).writeAsBytes(bytes);
    } else {
      print("opening data first");
    }
    return await sqfData.openDatabase(path, version: version);
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

  Future<List<Map<String, dynamic>>> getAllData() async {
    Database? db = await database;
    return await db!.query(TableName);
  }

  Future<int> deleteAll() async {
    Database? db = await database;
    return await db!.delete(TableName);
  }

  Future<List> searchBar(String name) async {
    Database? db = await database;
    return db!.query(TableName, where: Name, whereArgs: [name]);
  }

  Future update(
    String Table,
    String Column,
    String valus,
    String id,
  ) async {
    final db = await database;
    return await db!
        .update(Table, {Column: valus}, where: 'ID = ?', whereArgs: [id]);
  }

  Future<void> updateSellCol(double newValue) async {
    final db = await database;

    // Get the existing values from the column
    List<Map<String, dynamic>> rows = await db!.query(TableName);

    // Update the values by adding the new value
    List<Map<String, dynamic>> updatedRows = rows.map((row) {
      double oldValue = double.parse(row[Sell]);
      double updatedValue = oldValue + newValue;
      return {...row, Sell: updatedValue};
    }).toList();

    // Update the table with the updated values
    Batch batch = db.batch();
    for (var row in updatedRows) {
      batch.update(
        TableName,
        row,
        where: 'id = ?',
        whereArgs: [row[id]],
      );
      log(row[id].toString());
    }
    await batch.commit();
  }

  Future<void> updateCostCol(double newValue) async {
    final db = await database;

    List<Map<String, dynamic>> rows = await db!.query(TableName);

    List<Map<String, dynamic>> updatedRows = rows.map((row) {
      String num = row[Cost].toString().replaceAll(
            RegExp(r'[^0-9.]'),
            '',
          );
      log('____$num');

      double oldValue = double.parse(num);
      double updatedValue = oldValue + newValue;
      return {...row, Cost: updatedValue};
    }).toList();
    Batch batch = db.batch();
    for (var row in updatedRows) {
      batch.update(
        TableName,
        row,
        where: 'id = ?',
        whereArgs: [row[id]],
      );
      log('___${row[id].toString()}');
    }
    await batch.commit();
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
