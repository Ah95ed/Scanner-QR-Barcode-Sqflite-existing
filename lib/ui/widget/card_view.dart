import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/database/DataBaseHelper.dart';
import 'package:scanner_qr_barcode/Utils/stateManagment/provider.dart';
import '../../model/User.dart';

class CardView extends StatefulWidget {
  const CardView({super.key});

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  TextEditingController name = TextEditingController();
  TextEditingController barcode = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController sell = TextEditingController();
  bool isLaodingMore = false;
  ScrollController controller = ScrollController();
  List<User> items = [];
  int skip = 0;
  int limit = 20;

  getData() async {
    var dataList =
        await DataBaseHelper.getAllUser(skip.toString(), limit.toString());
    var item = dataList!
        .map((items) => User(
              name: items!['Name'].toString(),
              barcode: items['Barcode'].toString(),
              cost: items['Cost'].toString(),
              sell: items['Sell'].toString(),
              id: items['ID'].toString(),
            ))
        .toList();
    setState(() {
      items.addAll(item);
    });
  }

  @override
  void initState() {
    getData();
    controller.addListener(() async {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        setState(() {
          isLaodingMore = true;
        });
        skip = skip + limit;
        getData();
        setState(() {
          isLaodingMore = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Consumer<MainProvider>(
      builder: ((context, mainProvider, child) {
        return ListView.builder(
          controller: controller,
          itemCount: isLaodingMore ? items.length + 1 : items.length,
          itemBuilder: (context, index) {
            // var provid = context.watch<MainProvider>().items;
            return Dismissible(
              key: ValueKey(items[index].id),
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("تعديل البيانات"),
                        actions: [
                          Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Name Item',
                                ),
                                controller: name,
                              ),
                              TextFormField(
                                decoration:
                                    const InputDecoration(labelText: 'Barcode'),
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
                                  labelText: 'Sell',
                                ),
                                controller: sell,
                              ),
                            ],
                          ),
                          TextButton(
                            child: const Text('yes'),
                            onPressed: () async {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                  // return await Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return ShowInformation(
                  //         named: provid.name,
                  //         barcoded: provid.barcode,
                  //         selld: provid.sell,
                  //         idd: provid.id,
                  //         costd: provid.cost,
                  //       );
                  //     },
                  //   ),
                  // );
                } else if (di == DismissDirection.startToEnd) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        //add dialog to update data
                        title: Text(
                          'هل انت متأكد من حذف \n${items[index].name}',
                        ),
                        actions: [
                          TextButton(
                            child: const Text('yes'),
                            onPressed: () {
                              mainProvider.deleteData(
                                items[index].id,
                              );
                              Navigator.of(context).pop();
                              // rebuildUi();
                              setState(() {});
                            },
                          ),
                          const SizedBox(
                            width: double.minPositive,
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
              },
              child: Card(
                elevation: 8,
                child: ListTile(
                  title: Text(
                    items[index].name,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  subtitle: Text(
                    items[index].sell,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

// class Search extends StatelessWidget {
//   Search({super.key});
//   TextEditingController controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       cursorHeight: 12.0,
//       decoration: const InputDecoration(
//         labelText: 'Search',
//         hintText: 'البحث',
//       ),
//       controller: controller,
//     );
//   }
// }
