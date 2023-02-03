import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/stateManagment/provider.dart';
import '../widget/future_builder.dart';
import 'AddData.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var rebuild = Provider.of<MainProvider>(context);
    return ChangeNotifierProvider<MainProvider>(
      create: (_) => MainProvider(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 35.0,
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 150, 0, 72),
          title: Text(
            context.read<MainProvider>().barcodeScanRes.toString(),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              size: 32.0,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                context.read<MainProvider>().openCamera(context);
              },
              icon: const Icon(
                Icons.camera_alt_outlined,
                size: 28.0,
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  size: 28.0,
                )),
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
