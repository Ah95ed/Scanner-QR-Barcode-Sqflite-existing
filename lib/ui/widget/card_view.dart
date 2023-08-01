import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/model/stateManagment/provider.dart';
import 'package:scanner_qr_barcode/ui/widget/CardProfessions.dart';
import 'package:sizer/sizer.dart';

class CardView extends StatelessWidget {
  CardView({super.key});

  TextEditingController name = TextEditingController();
  TextEditingController barcode = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController sell = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    context.read<MainProvider>().paginationData();
    return Consumer<MainProvider>(
      builder: ((context, v, child) {
        return v.todoItem.isEmpty
            ? Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      SizedBox(
                        height: 8.h,
                      ),
                      const Text('Waiting ...')
                    ]),
              )
            : ListView.builder(
                controller: v.controller,
                itemCount:
                    v.isLaodingMore ? v.todoItem.length + 1 : v.todoItem.length,
                itemBuilder: (context, index) {
                  // var provid = context.watch<MainProvider>().items;
                  return Dismissible(
                    key: ValueKey(v.todoItem[index].id),
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
                            name.text = v.todoItem[index].name;
                            barcode.text = v.todoItem[index].barcode;
                            sell.text = v.todoItem[index].sell;
                            cost.text = v.todoItem[index].cost;
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
                                      decoration: const InputDecoration(
                                          labelText: 'Barcode'),
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
                                  child: const Text('Edit'),
                                  onPressed: () async {
                                    await v.updateName(
                                        name.text, v.todoItem[index].id);
                                    await v.updateBarCode(
                                        barcode.text, v.todoItem[index].id);
                                    await v.updateCost(
                                        cost.text, v.todoItem[index].id);
                                    await v.updateSell(
                                        sell.text, v.todoItem[index].id);

                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Close'),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else if (di == DismissDirection.startToEnd) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              //add dialog to update data
                              title: const Text(
                                'هل انت متأكد من حذف',
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('yes'),
                                  onPressed: () {
                                    v.deleteData(
                                      v.todoItem[index].id,
                                    );
                                    Navigator.of(context).pop();
                                    // rebuildUi();
                                  },
                                ),
                                const SizedBox(
                                  width: double.minPositive,
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
                    child: CardProfessions(
                      name: v.todoItem[index].name,
                      sell: v.todoItem[index].sell,
                    ),
                  );
                },
              );
      }),
    );
  }
}
