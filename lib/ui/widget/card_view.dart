import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/stateManagment/provider.dart';
import '../pages/ShowInformation.dart';

class CardView extends StatefulWidget {
  const CardView({super.key});

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  void initState() {
    Provider.of<MainProvider>(context, listen: false).selectData();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    Provider.of<MainProvider>(context, listen: false).selectData();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<MainProvider>(
      builder: ((context, mainProvider, child) {
        return ListView.builder(
          controller: context.read<MainProvider>().controller,
          itemCount: context.read<MainProvider>().isLaodingMore
              ? mainProvider.todoItem.length + 1
              : mainProvider.todoItem.length,
          itemBuilder: (context, index) {
            var provid = mainProvider.todoItem[index];
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
                          named: provid.name,
                          barcoded: provid.barcode,
                          selld: provid.sell,
                          idd: provid.id,
                          costd: provid.cost,
                        );
                      },
                    ),
                  );
                  setState(() {});
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
                            onPressed: () async {
                              context.read<MainProvider>().deleteData(
                                    provid.id,
                                  );
                              setState(() {});
                              // initState();
                              // context.read<MainProvider>().selectData();

                              // const CardView();
                              Navigator.of(context).pop();
                            },
                          ),
                          const SizedBox(
                            width: 150.0,
                          ),
                          TextButton(
                            onPressed: () => {Navigator.of(context).pop()},
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
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  subtitle: Text(
                    mainProvider.todoItem[index].sell,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            );
          },
        );
        // : const Center(
        //     child: Text(
        //       'Empty',
        //       style: TextStyle(
        //         color: Colors.red,
        //         fontSize: 28,
        //       ),
        //     ),
        //   );
      }),
    );
  }
}
