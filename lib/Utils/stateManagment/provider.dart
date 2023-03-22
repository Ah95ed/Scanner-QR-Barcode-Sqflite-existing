import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:scanner_qr_barcode/Utils/database/DataBaseHelper.dart';
import 'package:scanner_qr_barcode/model/User.dart';
import 'package:scanner_qr_barcode/ui/widget/CameraUp.dart';
import 'package:scanner_qr_barcode/ui/widget/CustomSearch_Delegate.dart';

class MainProvider extends ChangeNotifier {
  List<User> todoItem = [];
  String? barcodeScanRes;
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
    _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
      context: context,
      onCode: (code) {
        // barcodeScanRes = code.toString();
        searchBar(context,code.toString());
        notifyListeners();
      },
    );
    notifyListeners();
  }

  void searchBar(BuildContext context,String barcode) {
    showSearch(
      context: context,
      delegate: CustomSearchDelegate(resultes: barcode),
    );
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

  getData() async {
    var dataList =
        await DataBaseHelper.getAllUser(skip.toString(), limit.toString());
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

  lodingData() async {
    getData();
    controller.addListener(() async {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        isLaodingMore = true;

        skip = skip + limit;
        getData();

        isLaodingMore = false;
      }
    });
  }

  void deleteData(String id) {
    DataBaseHelper.delete(id);
    notifyListeners();
  }

  getDataAll() async {
    final data = await DataBaseHelper.dataAll();
    todoItem = data!
        .map(
          (e) => User(
            name: e!['Name'].toString(),
            barcode: e['Barcode'].toString(),
            cost: e['Cost'].toString(),
            sell: e['Sell'].toString(),
            id: e['ID'].toString(),
          ),
        )
        .toList();
    notifyListeners();
  }

  search(String name) async {
    final result = await DataBaseHelper.search(name);
    todoItem = result!
        .map((e) => User(
              name: e['Name'].toString(),
              barcode: e['Barcode'].toString(),
              cost: e['Cost'].toString(),
              sell: e['Sell'].toString(),
              id: e['ID'].toString(),
            ))
        .toList();
    notifyListeners();
  }
}
