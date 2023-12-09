import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/constant/Constant.dart';
import 'package:scanner_qr_barcode/model/stateManagment/provider.dart';
import 'package:sizer/sizer.dart';
import '../../generated/l10n.dart';
import '../../model/User.dart';
import '../pages/EditData.dart';
import 'Multi_text.dart';

// ignore: must_be_immutable
class CardItems extends StatelessWidget {
  String name, barcode, sell, cost, id;

  CardItems(
      {super.key,
      required this.name,
      required this.barcode,
      required this.cost,
      required this.sell,
      required this.id});

  @override
  Widget build(BuildContext context) {
    final prov = context.read<MainProvider>();
    return Card(
      elevation: 6,
      shadowColor: Colors.blueGrey,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Column(
              children: [
                MultiText(
                  name,
                  S.of(context).name,
                ),
                MultiText(
                  cost,
                  S.of(context).cost,
                ),
              
                MultiText(
                  sell,
                  S.of(context).sell,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(S.of(context).select),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    await prov.manageScreen(
                                      context,
                                      EditData.route,
                                      object: User(
                                        name: name,
                                        barcode: barcode,
                                        cost: cost,
                                        sell: sell,
                                        id: id,
                                      ),
                                    );
                                    //
                                  },
                                  child: Text(S.of(context).editData),
                                ),
                                TextButton(
                                  onPressed: () {
                                    prov.deleteData(
                                      id,
                                    );
                                    prov.todoItem.clear();
                                    prov.paginationData();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    S.of(context).delete,
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.more_horiz_outlined,
                    color: ColorUsed.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
