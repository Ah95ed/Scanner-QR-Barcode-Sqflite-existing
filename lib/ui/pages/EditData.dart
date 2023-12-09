import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/model/stateManagment/provider.dart';
import 'package:sizer/sizer.dart';
import '../../Utils/constant/Constant.dart';
import '../../generated/l10n.dart';
import '../../model/User.dart';

class EditData extends StatelessWidget {
  static const route = '/EditData';
  EditData({Key? key}) : super(key: key);
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController bar = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController sell = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User o = ModalRoute.of(context)!.settings.arguments as User;
    name.text = o.name;
    bar.text = o.barcode;
    cost.text = o.cost;
    sell.text = o.sell;
    final value = context.read<MainProvider>();

    return Consumer<MainProvider>(
      builder: (context, value, child) {
       TextEditingController? cont= value.barcode.text.isEmpty ? bar : value.barcode;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).editData,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: ColorUsed.primary,
            actions: [
              IconButton(
                onPressed: () {
                  value.openCameraInAddData(context);
                },
                icon: const Icon(Icons.camera_alt_outlined),
              ),
            ],
          ),
          body: ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(14),
            children: [
              Form(
                  child: Column(
                key: formState,
                children: [
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: S.of(context).name,
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: ColorUsed.primary),
                      ),
                      labelStyle: const TextStyle(
                        color: ColorUsed.primary,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TextFormField(
                    controller:
                       cont ,
                    decoration: InputDecoration(
                        labelText: S.of(context).barcode,
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: ColorUsed.primary),
                        ),
                        labelStyle: const TextStyle(color: ColorUsed.primary)),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TextFormField(
                    controller: cost,
                    decoration: InputDecoration(
                        labelText: S.of(context).cost,
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: ColorUsed.primary),
                        ),
                        labelStyle: const TextStyle(color: ColorUsed.primary)),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TextFormField(
                    controller: sell,
                    decoration: InputDecoration(
                        labelText: S.of(context).sell,
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: ColorUsed.primary),
                        ),
                        labelStyle: const TextStyle(color: ColorUsed.primary)),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      await value.updateName(name.text, o.id);
                      await value.updateBarCode(cont.text, o.id);
                      await value.updateCost(cost.text, o.id);
                      await value.updateSell(sell.text, o.id).whenComplete(
                            () => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(S().done),
                              ),
                            ),
                          );
                      value.todoItem.clear();
                      value.limit = 20;
                      value.skip = 0;
                      value.paginationData();

                    },
                    child: Text(
                      S().editData,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorUsed.primary,
                        fontSize: 16.sp,
                      ),
                    ),
                  )
                ],
              ))
            ],
          ),
        );
      },
    );
  }
}
