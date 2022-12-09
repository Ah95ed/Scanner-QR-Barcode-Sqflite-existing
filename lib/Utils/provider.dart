import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scanner_qr_barcode/Utils/DataBaseHelper.dart';
import 'package:scanner_qr_barcode/model/User.dart';
import 'package:scanner_qr_barcode/ui/ReadQrBarcode.dart';

import '../ui/Home.dart';

class MainProvider extends ChangeNotifier {
  List<User> todoItem = [];
  DataBaseHelper? db;
  String? barcodeScanRes = 'Scanner';

  Future<void> selectData() async {
    final dataList = await DataBaseHelper.getAllUser(DataBaseHelper.TableName);
    todoItem = dataList!
        .map((items) => User(
              name: items!['Name'].toString(),
              barcode: items['Barcode'].toString(),
              cost: items['Cost'].toString(),
              sell: items['Sell'].toString(),
              id: items['Id'].toString(),
            ))
        .toList();
    // Fluttertoast.showToast(
    //     msg: dataList.first.toString(),
    //     gravity: ToastGravity.CENTER,
    //     toastLength: Toast.LENGTH_SHORT);
    notifyListeners();
  }

  void updateData(
      TextEditingController name,
      TextEditingController barcode,
      TextEditingController cost,
      TextEditingController sell,
      String id,
      BuildContext context) async {
    int response = await db!.upDate(
        "Ahmed",
        {
          "Name": name.text,
          "Barcode": barcode.text,
          "Cost": cost.text,
          "Sell": sell.text,
        },
        "ID = $id}");
    if (response > 0) {
      Fluttertoast.showToast(msg: "تم التحديث", toastLength: Toast.LENGTH_LONG);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Home()), (route) => false);
    }
  }

  Future<void> openCamera() async {
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    notifyListeners();
  }
}
