// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../generated/l10n.dart';
import '../../model/stateManagment/provider.dart';
import 'CardProfessions.dart';
import 'DeleteDailog.dart';

class DismissibleWidget extends StatelessWidget {
  MainProvider v;
  int index;
  DismissibleWidget({
    Key? key,
    required this.v,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Dismissible(
      key: ValueKey(v.todoItem[index].id),
      background: Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.all(width * 0.01.sp),
        padding: EdgeInsets.all(width * 0.03.sp),
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
              return EditDialog(
                v: v,
                index: index,
              );
            },
          );
        } else if (di == DismissDirection.startToEnd) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DeleteDailog(
                v: v,
                index: index,
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
  }
}

class EditDialog extends StatelessWidget {
  MainProvider v;
  int index;
  EditDialog({
    Key? key,
    required this.v,
    required this.index,
  }) : super(key: key);

  TextEditingController name = TextEditingController();
  TextEditingController barcode = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController sell = TextEditingController();

  @override
  Widget build(BuildContext context) {
    name.text = v.todoItem[index].name;
    barcode.text = v.todoItem[index].barcode;
    sell.text = v.todoItem[index].sell;
    cost.text = v.todoItem[index].cost;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: AlertDialog(
        title: Text(S.of(context).editData),
        actions: [
          Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: S.of(context).name,
                ),
                controller: name,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: S.of(context).barcode,
                ),
                controller: barcode,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: S.of(context).cost,
                ),
                controller: cost,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: S.of(context).sell,
                ),
                controller: sell,
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                child: Text(S.of(context).edit),
                onPressed: () async {
                  await v.updateName(name.text, v.todoItem[index].id);
                  await v.updateBarCode(barcode.text, v.todoItem[index].id);
                  await v.updateCost(cost.text, v.todoItem[index].id);
                  await v.updateSell(sell.text, v.todoItem[index].id);
                  v.todoItem.clear();
                  v.paginationData();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(S.of(context).close),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
