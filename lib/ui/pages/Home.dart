import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/stateManagment/provider.dart';
import 'package:scanner_qr_barcode/ui/widget/CameraUp.dart';
import 'package:scanner_qr_barcode/ui/widget/CustomSearch_Delegate.dart';
import 'package:scanner_qr_barcode/ui/widget/card_view.dart';
import 'AddData.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provid = Provider.of<MainProvider>(context, listen: false);
    String? result = context.watch<MainProvider>().barcodeScanRes;
    return ChangeNotifierProvider<MainProvider>(
      create: (_) => MainProvider(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 8,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const QRViewExample(),
              ));
            },
            icon: const Icon(Icons.more_horiz_outlined),
          ),
          title: const Text('الشاشة الرئيسية'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<MainProvider>().lodingData();
                context.read<MainProvider>().searchBar(context);
              },
              icon: const Icon(Icons.search),
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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return AddData();
                },
              ),
            );
          },
          tooltip: 'Add',
          backgroundColor: const Color.fromARGB(255, 150, 0, 72),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 32.0,
          ),
        ),
        body: const CardView(),
      ),
    );
  }
}
