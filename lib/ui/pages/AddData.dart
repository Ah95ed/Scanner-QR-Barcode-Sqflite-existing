import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:scanner_qr_barcode/Utils/database/DataBaseHelper.dart';
import 'package:scanner_qr_barcode/Utils/stateManagment/provider.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);


@override
  State<AddData> createState() => _AddData();
}


class _AddData extends State<AddData> {



  DataBaseHelper db = DataBaseHelper.dataBaseHelper;
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController barcode = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController sell = TextEditingController();


  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  @override
  Widget build(BuildContext context) {
    // barcode.text = context.watch<MainProvider>().barcodeScanRes.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Data',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 150, 0, 72),
        actions: [
          IconButton(
            onPressed: () {
              _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                context: context,
                onCode: (code) {
                  setState(() {
                    barcode.text = code.toString();
                  });
            
                },
              );
            },
            icon: const Icon(Icons.camera_alt_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          int? response = await db.insert('''
          INSERT INTO Ahmed (`Name`,`BarCode`,`Cost`,`Sell`) VALUES
           ("${name.text}","${barcode.text}",
          "${cost.text}","${sell.text}")
          ''');
          if (response! > 0) {
            Navigator.of(context).pop();
          }
        },
        tooltip: 'Add',
        backgroundColor: const Color.fromARGB(255, 150, 0, 72),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32.0,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Form(
              child: Column(
            key: formState,
            children: [
              TextFormField(
                controller: name,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              TextFormField(
                controller: barcode,
                decoration: const InputDecoration(hintText: 'Barcode'),
              ),
              TextFormField(
                controller: cost,
                decoration: const InputDecoration(hintText: 'Cost'),
              ),
              TextFormField(
                controller: sell,
                decoration: const InputDecoration(hintText: 'Sell'),
              ),
            ],
          ))
        ],
      ),
    );
  }
 
}
