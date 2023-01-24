import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:scanner_qr_barcode/Utils/database/DataBaseHelper.dart';
import 'package:scanner_qr_barcode/model/User.dart';

class MainProvider extends ChangeNotifier {
  List<User> todoItem = [];
  String? barcodeScanRes;
  String? code;
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  Future<String?> selectData(int skip,int limit) async {

    final dataList = await DataBaseHelper.getAllUser(DataBaseHelper.TableName,skip.toString(),limit.toString());
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
    // skip = skip + limit;
    notifyListeners();
    return null;
  }

  Future<void> openCamera(BuildContext context) async {
    // try {
    //   barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
    //       '#ff6666', 'اللغاء', true, ScanMode.BARCODE);

    //     print(barcodeScanRes);

    // } on PlatformException {
    //   barcodeScanRes = 'Failed to get platform version.';
    // }
    _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
        context: context,
        onCode: (code) {
          barcodeScanRes = code.toString();
        });
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
