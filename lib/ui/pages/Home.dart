import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/constant/Constant.dart';
import 'package:scanner_qr_barcode/model/stateManagment/provider.dart';
import 'package:scanner_qr_barcode/ui/widget/card_view.dart';
import 'package:sizer/sizer.dart';
import '../widget/DrawerCostumer.dart';
import 'AddData.dart';

class Home extends StatelessWidget {
  static const String route = '/HOME';
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, value, child) {
        return Scaffold(
          drawer: const Drawer(
            backgroundColor: ColorUsed.primary,
            child: DrawerCostumer(),
          ),
          appBar: AppBar(
            elevation: 8,
            backgroundColor: ColorUsed.primary,

            title: value.title,
            actions: [
              IconButton(
                onPressed: () {
                  value.changeWidget();
                },
                icon: value.actionsicon,
              ),
              IconButton(
                onPressed: () async {
                  await context.read<MainProvider>().openCamera(context);
                },
                icon: const Icon(Icons.camera_alt_outlined),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              value.manageScreen(context, AddData.route);
            },
            tooltip: 'Add',
            backgroundColor: ColorUsed.primary,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 26.0.sp,
            ),
          ),
          body: CardView(),
        );
      },
    );
  }
}


