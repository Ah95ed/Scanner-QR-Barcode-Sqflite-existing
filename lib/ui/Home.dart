
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/DataBaseHelper.dart';
import 'package:scanner_qr_barcode/Utils/provider.dart';
import 'package:scanner_qr_barcode/ui/AddData.dart';
import 'package:scanner_qr_barcode/ui/ShowInformation.dart';

import 'ReadQrBarcode.dart';

class Home extends StatelessWidget {

  String? code;

  bool isLoading = true;

  Home({Key? key}) : super(key: key);

  // User user = User();
  // DataBaseHelper db = DataBaseHelper.dataBaseHelper;

  @override
  Widget build(BuildContext context) {
    final DataBaseHelper db = DataBaseHelper.dataBaseHelper;
    return ChangeNotifierProvider<MainProvider>(
      create: (_) => MainProvider(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 35.0,
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 150, 0, 72),
          title: const Text(
            'Scanner',
          ),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              size: 32.0,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {

                        return const Dialog(
                          child: QRViewExample() ,
                        );

                  });
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const QRViewExample())
                  // Provider.of<MainProvider>(context).openCamera(context);
                },
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  size: 28.0,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  size: 28.0,
                )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()  {
            Navigator.of(context).push(MaterialPageRoute(builder:
                (context){
              return const AddData();
            }));
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context){
    //       const QRViewExample()
    //     } )
    //
          },
          tooltip: 'Add',
          backgroundColor: const Color.fromARGB(255, 150, 0, 72),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 32.0,
          ),
        ),
        // body: isLoading == true
        //     ? const Center(
        //         child: Text(
        //           'Loading ... ',
        //           style: TextStyle(fontSize: 16.0, color: Colors.red),
        //         ),
        //       )
        body: FutureBuilder(
          future: Provider.of<MainProvider>(context, listen: false).selectData(),
          builder: ((context, snapshot) {
            Provider.of<MainProvider>(context).selectData();
            if (snapshot.connectionState == ConnectionState.done) {
              return Consumer<MainProvider>(
                builder: ((context, mainProvider, child) {
                  return mainProvider.todoItem.isNotEmpty
                      ? ListView.builder(
                    itemCount:  mainProvider.todoItem.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 8,
                        child: ListTile(
                          title: Text(mainProvider.todoItem[index].name),
                          subtitle: Text(
                              mainProvider.todoItem[index].sell+"\n${mainProvider.todoItem[index].barcode}"),
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return ShowInformation(
                                name: mainProvider.todoItem[index].name,
                                barcode: mainProvider.todoItem[index].barcode,
                                sell: mainProvider.todoItem[index].sell,
                                id: mainProvider.todoItem[index].id,
                              cost:mainProvider.todoItem[index].cost ,
                              );
                            }));
                          },
                        ),
                      );
                    },
                  ): const Center(
                    child: Text(
                      'Empty',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 28,
                      ),
                    ),
                  );
                }),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.amber,
                  color: Colors.black,
                  strokeWidth: 2,
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}



