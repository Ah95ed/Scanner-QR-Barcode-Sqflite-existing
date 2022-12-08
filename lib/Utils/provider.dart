import 'package:flutter/material.dart';
import 'package:scanner_qr_barcode/Utils/DataBaseHelper.dart';
import 'package:scanner_qr_barcode/model/User.dart';

class MainProvider extends ChangeNotifier {
  List<User> todoItem = [];

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
}
