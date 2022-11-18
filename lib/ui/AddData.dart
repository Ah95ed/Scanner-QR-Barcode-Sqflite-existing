import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scanner_qr_barcode/Utils/DataBaseHelper.dart';


class AddData extends StatefulWidget{
  const AddData({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddData();

}
class _AddData extends State<AddData>{


  DataBaseHelper db = DataBaseHelper.dataBaseHelper;
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController barcode = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController sell = TextEditingController();
  TextEditingController dose = TextEditingController();
  TextEditingController mostSide = TextEditingController();
  TextEditingController drugName = TextEditingController();
  TextEditingController mechanism = TextEditingController();
  TextEditingController pregnancy = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Add Data',
            style: TextStyle(color: Colors.white)
            ,
          ),

        backgroundColor:const Color.fromARGB(255, 150, 0, 72),
        actions: [
          IconButton(onPressed: () {}, icon:const Icon( Icons.camera_alt_outlined)),
        ],
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () async {
         int? response =  await
          db.insert('''
          INSERT INTO Ahmed (`Name`,`BarCode`,`Cost`,`Sell`,`dose`,`mostSide`,`drugName`,`mechanism`,`pregnancy`) VALUES
           ("${name.text}","${barcode.text}",
          "${cost.text}","${sell.text}")
          ''');
         if(response! > 0){
           Fluttertoast.showToast(msg: " ${name.text}تمت اَضافة ",toastLength: Toast.LENGTH_SHORT);
         }
        } ,
        tooltip: 'Add',
        backgroundColor: const  Color.fromARGB(255, 150, 0, 72),
        child: const Icon(
          Icons.add,
          color: Colors.white
          ,size: 32.0,),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children:  [
          Form(child: Column(
            key: formState,
            children:  [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'name'
                ),
                controller: name,
              ),
              TextFormField(
                controller: barcode,
                decoration:const InputDecoration(
                    hintText: 'barcode'
                ),
              ),
              TextFormField(
                decoration:const InputDecoration(
                    hintText: 'cost'
                ),
                controller: cost,
              ),
              TextFormField(
                decoration:const InputDecoration(
                    hintText: 'sell'
                ),
                controller: sell,
              ),
            ],
          ))
        ],
      ),
    );
  }

}