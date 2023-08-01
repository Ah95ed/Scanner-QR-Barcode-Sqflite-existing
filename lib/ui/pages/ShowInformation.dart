import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/database/DataBaseHelper.dart';
import 'package:scanner_qr_barcode/model/stateManagment/provider.dart';

class ShowInformation extends StatelessWidget {
  static const route = "/ShowInformation";

  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController name = TextEditingController();

  TextEditingController barcode = TextEditingController();

  TextEditingController cost = TextEditingController();

  TextEditingController sell = TextEditingController();

  DataBaseHelper? _db ;

  ShowInformation({super.key}) {
    _db = DataBaseHelper();
  }
  late String _id;

  @override
  Widget build(BuildContext context) {
    /*
   needed StatelessWidget
   */
    final provider = Provider.of<MainProvider>(context, listen: false);
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
          Expanded(
            flex: 1,
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
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await provider.updateName(name.text, _id);
          await provider.updateBarCode(barcode.text, _id);
          await provider.updateCost(cost.text, _id);
          await provider.updateSell(sell.text, _id);
          // provider.selectData();
          // context.read<MainProvider>().selectData();
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
