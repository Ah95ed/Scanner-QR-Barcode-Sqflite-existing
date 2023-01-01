import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/DataBaseHelper.dart';
import 'package:scanner_qr_barcode/Utils/provider.dart';

class ShowInformation extends StatefulWidget {
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

  @override
  State<ShowInformation> createState() => _ShowInformationState();
}

class _ShowInformationState extends State<ShowInformation> {
  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController name = TextEditingController();

  TextEditingController barcode = TextEditingController();

  TextEditingController cost = TextEditingController();

  TextEditingController sell = TextEditingController();

  DataBaseHelper db = DataBaseHelper.dataBaseHelper;
  late String _id ;
  @override
  void initState() {
    name.text = widget.named;
    barcode.text = widget.barcoded;
    cost.text = widget.costd;
    sell.text = widget.selld;
    _id = widget.idd ;
    super.initState();
  }
  @override
  void dispose() {
    name.dispose();
    barcode.dispose();
    cost.dispose();
    sell.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*
   needed StatelessWidget
   */
    final provider = Provider.of<MainProvider>(context,listen: false);
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
          await provider.updateName(name.text, _id );
          await provider.updateBarCode(barcode.text,_id);
          await provider.updateCost(cost.text, _id);
          await provider.updateSell(sell.text, _id);
          // Fluttertoast.showToast(msg: name.text,toastLength: Toast.LENGTH_SHORT,
          //
          // fontSize: 16.0,gravity: ToastGravity.BOTTOM,backgroundColor: Colors.amber
          // );
          Navigator.pop(context);
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
