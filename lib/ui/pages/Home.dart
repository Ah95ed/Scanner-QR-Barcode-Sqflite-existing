import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/stateManagment/provider.dart';
import 'package:scanner_qr_barcode/ui/widget/CustomSearch_Delegate.dart';
import 'package:scanner_qr_barcode/ui/widget/future_builder.dart';
import 'AddData.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainProvider>(
      create: (_) => MainProvider(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 8,
          leading: const Icon(Icons.more_horiz),
          title: Text(context.watch<MainProvider>().barcodeScanRes.toString()),
          actions: [
            IconButton(
              onPressed: () {
                context.read<MainProvider>().lodingData();
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
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
        body: const BodyScreen(),
      ),
    );
  }
}
