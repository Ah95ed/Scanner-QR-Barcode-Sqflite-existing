
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:scanner_qr_barcode/Utils/DataBaseHelper.dart';
import 'package:scanner_qr_barcode/model/User.dart';


class MainProvider extends ChangeNotifier {
  List<User> todoItem = [];
  String? barcodeScanRes;
  String? code;

  Future<void> selectData() async {
    final dataList = await DataBaseHelper.getAllUser(DataBaseHelper.TableName);
    todoItem = dataList!
        .map((items) => User(
              name: items!['Name'].toString(),
              barcode: items['Barcode'].toString(),
              cost: items['Cost'].toString(),
              sell: items['Sell'].toString(),
              id: items['ID'].toString(),
            ))
        .toList();
    // Fluttertoast.showToast(
    //     msg: dataList.first.toString(),
    //     gravity: ToastGravity.CENTER,
    //     toastLength: Toast.LENGTH_SHORT);
    notifyListeners();
  }

  Future<void> openCamera() async {

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'اللغاء', true, ScanMode.BARCODE);
 
        print(barcodeScanRes);
      

    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    notifyListeners();
  }
  Future updateName(String name, String id) async {
    await DataBaseHelper.update(
      DataBaseHelper.TableName,
      DataBaseHelper.Name,
      name,
      id,
    );
    notifyListeners();
  }
  Future updateBarCode(String Barcode, String id) async {
    await DataBaseHelper.update(
      DataBaseHelper.TableName,
      DataBaseHelper.BarCode,
      Barcode,
      id,
    );
    notifyListeners();
  }
  Future updateCost(String Cost, String id) async {
    await DataBaseHelper.update(
      DataBaseHelper.TableName,
      DataBaseHelper.Cost,
      Cost,
      id,
    );
    notifyListeners();
  }
  Future updateSell(String Sell, String id) async {
    await DataBaseHelper.update(
      DataBaseHelper.TableName,
      DataBaseHelper.Sell,
      Sell,
      id,
    );
    notifyListeners();
  }
}
