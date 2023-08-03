import 'dart:developer';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scanner_qr_barcode/Utils/database/DataBaseHelper.dart';
import 'package:scanner_qr_barcode/main.dart';
import 'package:scanner_qr_barcode/model/User.dart';
import 'package:sizer/sizer.dart';

import '../../generated/l10n.dart';

class MainProvider extends ChangeNotifier {
  List<User> todoItem = [];
  List<User> copys = [];
  List<User> search = [];
  List<User> allItems = [];
  DataBaseHelper? _baseHelper;
  QRViewController? qrcontroller;
  Widget title = Text(S().mainScreen);
  Icon actionsicon = const Icon(Icons.search);
  final TextEditingController text = TextEditingController();
  TextEditingController barcode = TextEditingController();

  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  MainProvider() {
    _baseHelper ??= DataBaseHelper();
  }

  Future<void> changeWidget() async {
    if (actionsicon.icon == Icons.search) {
      copys = todoItem;

      actionsicon = const Icon(Icons.close);
      title = TextField(
        controller: text,
        keyboardType: TextInputType.text,
        style: TextStyle(
            fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white),
        textAlign: TextAlign.start,
        autofocus: true,
        onChanged: (value) {
          searchInData(value);
        },
      );
    } else {
      todoItem = copys;
      copys = [];
      search = [];
      text.text = '';
      actionsicon = const Icon(Icons.search);
      title = Text(S().mainScreen);
    }
    notifyListeners();
  }

  Future<void> manageScreen(BuildContext context, String route) async {
    Navigator.pushNamed(context, route);
    notifyListeners();
  }

  Future<void> exportData(BuildContext context) async {
    await getAllData();
    await Future.delayed(
      const Duration(seconds: 2),
      () async {
        if (allItems.isEmpty) return;

        final data = allItems.map((row) {
          List t = [];
          t.add(row.name);
          t.add(row.barcode);
          t.add(row.cost);
          t.add(row.sell);
          t.add(row.id);
          return t.toList();
        }).toList();
        await Permission.storage.request();
        await Permission.manageExternalStorage.request();
        final p = await Permission.accessMediaLocation.request();

        if (p.isGranted) {
          String? result = await FilePicker.platform.getDirectoryPath();
          if (result != null) {
            final file = File('$result/data.csv');
            String? csvString = const ListToCsvConverter().convert(data);
            await file
                .writeAsString(csvString)
                .whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(S.of(context).ExportedisDone)),
                    ));
          }
        }
        notifyListeners();
      },
    );
  }

  Future<void> searchInData(String name) async {
    List<Map<String, dynamic>>? result =
        await _baseHelper?.searchInDatabase(name);
    List<User> newResult = result!
        .map(
          (item) => User(
            name: item[DataBaseHelper.Name],
            barcode: item[DataBaseHelper.BarCode] ?? '',
            cost: item[DataBaseHelper.Cost] ?? '',
            sell: item[DataBaseHelper.Sell],
            id: item[DataBaseHelper.id].toString(),
          ),
        )
        .toList();
    todoItem.clear();
    todoItem = newResult;
    notifyListeners();
  }

  Future<void> openCamera(BuildContext context) async {
    copys = todoItem;
    _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
      context: context,
      onCode: (code) {
        searchBarCode(code!);
      },
    );
    notifyListeners();
  }

  Future<void> openCameraInAddData(BuildContext context) async {
    copys = todoItem;
    _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
      context: context,
      onCode: (code) {
        barcode.text = code!.toString();
        notifyListeners();
      },
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
  int skip = 0;
  int limit = 20;

  void deleteData(String id) {
    _baseHelper!.delete(id);
    notifyListeners();
  }

  Future<void> getAllData() async {
    final data = await _baseHelper!.getAllData();
    allItems = data
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

  Future<void> paginationData() async {
    if (todoItem.isEmpty) {
      getPData();
    }
    controller.addListener(
      () async {
        if (controller.position.pixels == controller.position.maxScrollExtent) {
          isLaodingMore = true;
          getPData();
          skip = skip + limit;

          isLaodingMore = false;
        }
      },
    );
  }

  Future<void> getPData() async {
    // DataBaseHelper _baseHelper = DataBaseHelper();
    var dataList =
        await _baseHelper!.getAllUser(skip.toString(), limit.toString());
    var item = dataList!
        .map((items) => User(
              name: items!['Name'].toString(),
              barcode: items['Barcode'].toString(),
              cost: items['Cost'].toString(),
              sell: items['Sell'].toString(),
              id: items['ID'].toString(),
            ))
        .toList();
    log('${item.length} ____');

    todoItem.addAll(item);
    notifyListeners();
  }

  Future<void> searchBarCode(String s) async {
    copys = todoItem;
    List<Map<String, dynamic>>? result = await _baseHelper?.searchBarCode(s);
    List<User> newResult = result!
        .map(
          (item) => User(
            name: item[DataBaseHelper.Name],
            barcode: item[DataBaseHelper.BarCode] ?? '',
            cost: item[DataBaseHelper.Cost] ?? '',
            sell: item[DataBaseHelper.Sell] ?? '',
            id: item[DataBaseHelper.id].toString(),
          ),
        )
        .toList();
    todoItem.clear();
    todoItem = newResult;
    newFunction();
    notifyListeners();
  }

  void newFunction() async {
    await Future.delayed(
      const Duration(seconds: 5),
      () {
        todoItem = copys;
        copys = [];
        notifyListeners();
      },
    );
  }

  Future<void> onQRViewCreated(QRViewController controller) async {
    // setState(() {
    qrcontroller = controller;
    // });
    controller.scannedDataStream.listen((scanData) {
      qrcontroller!.pauseCamera();
      searchCodeOrder(scanData.code!);
    });
  }

  List<User> order = [];
  double resultSell = 0.0;
  late int i;
  Future<void> searchCodeOrder(String s) async {
    copys = todoItem;
    i = 0;
    final cctx = navigatorKey.currentContext;
    List<Map<String, dynamic>>? result =
        await _baseHelper?.searchBarCodeOrder(s);
    List<User>? newResult = result!
        .map(
          (item) => User(
            name: item[DataBaseHelper.Name],
            barcode: item[DataBaseHelper.BarCode],
            cost: item[DataBaseHelper.Cost],
            sell: item[DataBaseHelper.Sell],
            id: item[DataBaseHelper.id].toString(),
          ),
        )
        .toList();
    if (newResult.isEmpty) {
      ScaffoldMessenger.of(cctx!).showSnackBar(
        SnackBar(
          content: Text(S.of(cctx).isempty),
        ),
      );
      qrcontroller!.resumeCamera();
      notifyListeners();
      return;
    }

    resultSell += double.parse(newResult[i].sell);
    i++;
    order.addAll(newResult);

    notifyListeners();
    qrcontroller!.resumeCamera();
  }

  clearOrder() {
    order.clear();
    resultSell = 0.0;
    i = 0;
    notifyListeners();
  }

  Future insertData(
      String name, String barcode, String cost, String sell) async {
    final cctx = navigatorKey.currentContext;
    Future<int?> result = _baseHelper!.addData(name, barcode, cost, sell);
    int? response = await result;
    if (response! > 0) {
      ScaffoldMessenger.of(cctx!).showSnackBar(
        SnackBar(
          content: Text(S.of(cctx).done),
        ),
      );
      notifyListeners();
    } else {
      ScaffoldMessenger.of(cctx!).showSnackBar(
        SnackBar(
          // ignore: use_build_context_synchronously
          content: Text(S.of(cctx).error),
        ),
      );
    }
  }
}
