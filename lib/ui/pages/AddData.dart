import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/constant/Constant.dart';
import 'package:scanner_qr_barcode/Utils/database/DataBaseHelper.dart';
import 'package:scanner_qr_barcode/generated/l10n.dart';
import 'package:scanner_qr_barcode/model/stateManagment/provider.dart';
import 'package:sizer/sizer.dart';

class AddData extends StatelessWidget {
  static const route = '/AddData';

  DataBaseHelper? _db;
  AddData({super.key}) {
    _db = DataBaseHelper();
  }

  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController name = TextEditingController();

  TextEditingController cost = TextEditingController();

  TextEditingController sell = TextEditingController();

  // final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).addData,
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
            padding: EdgeInsets.all(10.sp),
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
                    controller: value.barcode,
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
                      await value.insertData(
                        name.text,
                        value.barcode.text,
                        cost.text,
                        sell.text,
                      );
                    },
                    child: Text(
                      S().addData,
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
