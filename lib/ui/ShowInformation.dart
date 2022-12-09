import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/DataBaseHelper.dart';
import 'package:scanner_qr_barcode/Utils/provider.dart';
import 'Home.dart';

class ShowInformation extends StatelessWidget {
  String named;
  String barcoded;
  String costd;
  String selld;
  String idd;
// bool isUpdate
  ShowInformation({
    Key? key,
    required this.named,
    required this.barcoded,
    required this.costd,
    required this.selld,
    required this.idd,
  }) : super(key: key);

  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController barcode = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController sell = TextEditingController();
  DataBaseHelper db = DataBaseHelper.dataBaseHelper;

  @override
  Widget build(BuildContext context) {
   /*
   needed StatelessWidget
   */
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 150, 0, 72),
        title: const Text(
          'Show Info Item',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
          ),
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
                decoration: const InputDecoration(
                  labelText: 'Name Item',
                ),
                controller: name,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Barcode'),
                controller: barcode,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'cost',
                ),
                controller: cost,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'sell',
                ),
                controller: sell,
              ),
            ],
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Provider.of<MainProvider>(context).updateData(
            name,
            barcode,
            cost,
            sell,
            idd,
            context,
          );
          // int response = await db.upDate(
          //     "Ahmed",
          //     {
          //       "Name": name.text,
          //       "Barcode": barcode.text,
          //       "Cost": cost.text,
          //       "Sell": sell.text,
          //     },
          //     "ID = $idd");
          // if (response > 0) {
          //   Fluttertoast.showToast(
          //       msg: "تم التحديث", toastLength: Toast.LENGTH_LONG);
          //   Navigator.of(context).pushAndRemoveUntil(
          //       MaterialPageRoute(builder: (context) => Home()),
          //       (route) => false);
          // }
        },
        backgroundColor: const Color.fromARGB(255, 150, 0, 72),
        tooltip: 'Add And UpDate',
        child: const Icon(
          Icons.add,
          size: 28.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
