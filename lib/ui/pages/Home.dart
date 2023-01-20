import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:scanner_qr_barcode/Utils/stateManagment/provider.dart';
import 'package:scanner_qr_barcode/ui/pages/ShowInformation.dart';
// import 'package:scanner_qr_barcode/ui/pages/screen_Calc.dart';
import 'AddData.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  String? code;
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();

  bool isLoading = true;

  Home({Key? key}) : super(key: key);

  // User user = User();
  // DataBaseHelper db = DataBaseHelper.dataBaseHelper;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider<MainProvider>(
      create: (_) => MainProvider(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 35.0,
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 150, 0, 72),
          title: Text(
            Provider.of<MainProvider>(context, listen: false).barcodeScanRes ==
                    null
                ? "MainPage"
                : context.watch<MainProvider>().barcodeScanRes.toString(),
          ),
          leading: IconButton(
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: ((context) => const Calcolator()),),;
            },
            icon: const Icon(
              Icons.menu,
              size: 32.0,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  Provider.of<MainProvider>(context, listen: false)
                      .openCamera(context);
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
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
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
          future:
              Provider.of<MainProvider>(context, listen: false).selectData(),
          builder: ((context, snapshot) {
            Provider.of<MainProvider>(context).selectData();
            if (snapshot.connectionState == ConnectionState.done) {
              return Consumer<MainProvider>(
                builder: ((context, mainProvider, child) {
                  return mainProvider.todoItem.isNotEmpty
                      ? ListView.builder(
                          itemCount: mainProvider.todoItem.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: ValueKey(mainProvider.todoItem[index].id),
                              background: Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.all(width * 0.01),
                                  padding: EdgeInsets.all(width * 0.03),
                                  // decoration: BoxDecoration(
                                  //   color: Colors.green,
                                  //   borderRadius:
                                  //       BorderRadius.circular(width * 0.03),
                                  // ),
                                  color: Colors.green,
                                  height: height * 0.02,
                                  width: width,
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  )),
                              confirmDismiss: (DismissDirection di) async {
                                if (di == DismissDirection.endToStart) {
                                  return await Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return ShowInformation(
                                      named: mainProvider.todoItem[index].name,
                                      barcoded:
                                          mainProvider.todoItem[index].barcode,
                                      selld: mainProvider.todoItem[index].sell,
                                      idd: mainProvider.todoItem[index].id,
                                      costd: mainProvider.todoItem[index].cost,
                                    );
                                  }));
                                } else if (di == DismissDirection.startToEnd) {
                                  Fluttertoast.showToast(
                                      msg: mainProvider.todoItem[index].id,
                                      toastLength: Toast.LENGTH_SHORT,
                                      fontSize: 16.0,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.amber);
                                  // showDialog(
                                  //   context: context,
                                  //   builder: ((context) => Qr()),
                                  //   useSafeArea: true,
                                  //
                                  //   //  ((context) => const AlertDialog(
                                  //   //       title: Text('Delete'),
                                  //   //     )),
                                  // );
                                }
                              },
                              child: Card(
                                elevation: 8,
                                child: ListTile(
                                  title:
                                      Text(mainProvider.todoItem[index].name),
                                  subtitle:
                                      Text(mainProvider.todoItem[index].sell),

                                  // onTap: () {
                                  //   Navigator.of(context).push(
                                  //       MaterialPageRoute(builder: (context) {
                                  //     return ShowInformation(
                                  //       named:
                                  //           mainProvider.todoItem[index].name,
                                  //       barcoded: mainProvider
                                  //           .todoItem[index].barcode,
                                  //       selld:
                                  //           mainProvider.todoItem[index].sell,
                                  //       idd: mainProvider.todoItem[index].id,
                                  //       costd:
                                  //           mainProvider.todoItem[index].cost,
                                  //     );
                                  //   }));
                                  // },
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
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
