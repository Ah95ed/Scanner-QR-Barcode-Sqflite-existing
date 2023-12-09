import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:scanner_qr_barcode/generated/l10n.dart';
import 'package:scanner_qr_barcode/model/stateManagment/provider.dart';
import 'CardProfessions.dart';

class CardView extends StatelessWidget {
  const CardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: ((context, v, child) {
        v.paginationData();
        return v.todoItem.isEmpty
            ? Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(S().wait),
                    ]),
              )
            : ListView.builder(
                controller: v.controller,
                itemCount:
                    v.isLaodingMore ? v.todoItem.length + 1 : v.todoItem.length,
                itemBuilder: (context, index) {
                  return CardItems(
                      name: v.todoItem[index].name,
                      barcode: v.todoItem[index].barcode,
                      sell: v.todoItem[index].sell,
                      cost: v.todoItem[index].cost,
                      id: v.todoItem[index].id);
                },
              );
      }),
    );
  }
}
