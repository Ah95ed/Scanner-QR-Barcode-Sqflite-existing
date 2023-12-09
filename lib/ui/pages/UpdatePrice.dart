import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/constant/Constant.dart';
import 'package:scanner_qr_barcode/generated/l10n.dart';
import 'package:scanner_qr_barcode/model/stateManagment/provider.dart';
import 'package:sizer/sizer.dart';

class UpdatePrice extends StatelessWidget {
  static const route = '/UpdatePrice';
  UpdatePrice({Key? key}) : super(key: key);
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController? cost = TextEditingController();
  TextEditingController? sell = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provid = context.read<MainProvider>();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).update_prices,
            ),
            backgroundColor: ColorUsed.primary,
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: cost,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: S.of(context).update_cost,
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: ColorUsed.primary),
                            ),
                            labelStyle:
                                const TextStyle(color: ColorUsed.primary)),
                      ),
                    ),
                    SizedBox(width: 1.w),
                    OutlinedButton(
                      onPressed: () async {
                          double newCost = double.parse(cost!.text);
                         await provid.updateCostColumn(newCost);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: ColorUsed.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8.sp), // Customize the button shape
                        ),
                        side: const BorderSide(
                            color: ColorUsed
                                .primary), // Customize the outline color
                      ),
                      child: Text(
                        S().update_cost,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: sell,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: S.of(context).update_sell,
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: ColorUsed.primary),
                            ),
                            labelStyle:
                                const TextStyle(color: ColorUsed.primary)),
                      ),
                    ),
                    SizedBox(width: 1.w),
                    OutlinedButton(
                      onPressed: () async {
                        double newSell = double.parse(sell!.text);
                        await provid.updateSellColumn(newSell);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: ColorUsed.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8.sp), // Customize the button shape
                        ),
                        side: const BorderSide(
                            color: ColorUsed
                                .primary), // Customize the outline color
                      ),
                      child: Text(
                        S().update_sell,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
