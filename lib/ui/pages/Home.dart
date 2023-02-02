import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/stateManagment/provider.dart';
import 'package:scanner_qr_barcode/ui/pages/ShowInformation.dart';
import 'AddData.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // var rebuild = Provider.of<MainProvider>(context);
    return ChangeNotifierProvider<MainProvider>(
      create: (_) => MainProvider(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 35.0,
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 150, 0, 72),
          title: Text(
            Provider.of<MainProvider>(context, listen: false).barcodeScanRes ==
                    ''
                ? "MainPage"
                : context.read<MainProvider>().barcodeScanRes.toString(),
          ),
          leading: IconButton(
            onPressed: () {
            
            },
            icon: const Icon(
              Icons.menu,
              size: 32.0,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                context.read<MainProvider>().openCamera(context);
              },
              icon: const Icon(
                Icons.camera_alt_outlined,
                size: 28.0,
              ),
            ),
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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return AddData();
                },
              ),
            );
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
          future: context.read<MainProvider>().selectData()
          // Provider.of<MainProvider>(context, listen: false).selectData()
          ,
          builder: ((context, snapshot) {
            context.read<MainProvider>().selectData();
            if (snapshot.connectionState == ConnectionState.done) {
              return Consumer<MainProvider>(
                builder: ((context, mainProvider, child) {
                  return mainProvider.todoItem.isNotEmpty
                      ? ListView.builder(
                          controller: controller,
                          itemCount:
                              context.read<MainProvider>().todoItem.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: ValueKey(mainProvider.todoItem[index].id),
                              background: Container(
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.all(width * 0.01),
                                padding: EdgeInsets.all(width * 0.03),
                                color: Colors.green,
                                height: height * 0.02,
                                width: width,
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                              confirmDismiss: (DismissDirection di) async {
                                if (di == DismissDirection.endToStart) {
                                  return await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ShowInformation(
                                          named:
                                              mainProvider.todoItem[index].name,
                                          barcoded: mainProvider
                                              .todoItem[index].barcode,
                                          selld:
                                              mainProvider.todoItem[index].sell,
                                          idd: mainProvider.todoItem[index].id,
                                          costd:
                                              mainProvider.todoItem[index].cost,
                                        );
                                      },
                                    ),
                                  );
                                } else if (di == DismissDirection.startToEnd) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'هل انت متأكد من حذف \n${mainProvider.todoItem[index].name}',
                                        ),
                                        actions: [
                                          TextButton(
                                            child: const Text('yes'),
                                            onPressed: () {
                                              context
                                                  .read<MainProvider>()
                                                  .deleteData(
                                                    context
                                                        .read<MainProvider>()
                                                        .todoItem[index]
                                                        .id,
                                                  );
                                              // rebuild.loadData();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          const SizedBox(
                                            width: 150.0,
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                {Navigator.of(context).pop()},
                                            child: const Text('No'),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                }
                                return null;
                              },
                              child: Card(
                                elevation: 8,
                                child: ListTile(
                                  title: Text(
                                    mainProvider.todoItem[index].name,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    mainProvider.todoItem[index].sell,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
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
