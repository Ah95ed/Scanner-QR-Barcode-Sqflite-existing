import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:scanner_qr_barcode/Utils/database/DataBaseHelper.dart';
import 'package:scanner_qr_barcode/model/User.dart';

class MainProvider extends ChangeNotifier {
  List<User> todoItem = [];
  String? barcodeScanRes = 'الشاشة الرئيسية';
  String? code;

  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();

  Future<List?> selectData({String? skip, String? limit}) async {
    final dataList = await DataBaseHelper.getAllUser(skip!, limit!);
    todoItem = dataList!
        .map((items) => User(
              name: items!['Name'].toString(),
              barcode: items['Barcode'].toString(),
              cost: items['Cost'].toString(),
              sell: items['Sell'].toString(),
              id: items['ID'].toString(),
            ))
        .toList();
    notifyListeners();
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

  Future updateBarCode(String barcode, String id) async {
    await DataBaseHelper.update(
      DataBaseHelper.TableName,
      DataBaseHelper.BarCode,
      barcode,
      id,
    );
    notifyListeners();
  }

  Future updateCost(String cost, String id) async {
    await DataBaseHelper.update(
      DataBaseHelper.TableName,
      DataBaseHelper.Cost,
      cost,
      id,
    );
    notifyListeners();
  }

  Future updateSell(String sell, String id) async {
    await DataBaseHelper.update(
      DataBaseHelper.TableName,
      DataBaseHelper.Sell,
      sell,
      id,
    );
    notifyListeners();
  }

  bool isLaodingMore = false;
  ScrollController controller = ScrollController();
  List<User> items = [];
  int skip = 0;
  int limit = 20;
  void notfy(VoidCallback fn) {
    fn() {
      notifyListeners();
    }
  }

  getData() async {
    var dataList =
        await DataBaseHelper.getAllUser(skip.toString(), limit.toString());
    var item = dataList!
        .map((items) => User(
              name: items!['Name'].toString(),
              barcode: items['Barcode'].toString(),
              cost: items['Cost'].toString(),
              sell: items['Sell'].toString(),
              id: items['ID'].toString(),
            ))
        .toList();
    notfy(() {
      items.addAll(item);
    });
  }

  lodingData() async {
    getData();
    controller.addListener(() async {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        notfy(() {
          isLaodingMore = true;
        });
        skip = skip + limit;
        getData();
        notfy(() {
          isLaodingMore = false;
        });
      }
    });
  }

  void deleteData(String id) {
    DataBaseHelper.delete(id);
    notifyListeners();
  }

  getDataAll() async {
    final data = DataBaseHelper.dataAll();
    todoItem = data
        .map(
          (e) => User(
            name: e['Name'].toString(),
            barcode: e['Barcode'].toString(),
            cost: e['Cost'].toString(),
            sell: e['Sell'].toString(),
            id: e['ID'].toString(),
          ),
        )
        .toList();
    notifyListeners();
  }
}
