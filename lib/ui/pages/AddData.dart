import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/database/DataBaseHelper.dart';
import 'package:scanner_qr_barcode/Utils/stateManagment/provider.dart';

class AddData extends StatelessWidget {
  AddData({Key? key}) : super(key: key);

  DataBaseHelper db = DataBaseHelper.dataBaseHelper;
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController barcode = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController sell = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              Provider.of<MainProvider>(context, listen: false)
                  .openCamera(context);
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
            // Fluttertoast.showToast(
            //     msg: " ${name.text}تمت اَضافة ",
            //     gravity: ToastGravity.CENTER,
            //     toastLength: Toast.LENGTH_SHORT);
          } else {}
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
              TextField(
                "sell",
                controller: sell,
              ),
              TextFormField(
                controller: barcode,
                decoration: const InputDecoration(hintText: 'barcode'),
              ),
              TextField(
                "sell",
                controller: sell,
              ),
              TextField(
                "sell",
                controller: sell,
              ),
            ],
          ))
        ],
      ),
    );
  }
}

class TextField extends StatelessWidget {
  final String? hint;
  TextEditingController controller = TextEditingController();

  TextField(String s, {Key? key, this.hint, required this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
      ),
      controller: controller,
    );
  }
}
