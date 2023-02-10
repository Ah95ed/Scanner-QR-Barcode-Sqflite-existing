import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/ui/widget/card_view.dart';
import '../../Utils/stateManagment/provider.dart';

class BodyScreen extends StatelessWidget {
  const BodyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<MainProvider>(context, listen: false).selectData(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer<MainProvider>(
              builder: (context, mainprovider, child) {
            return CardView();
          });
        } else {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.amber,
              color: Colors.black,
              strokeWidth: 2,
            ),
          );
        }
      }),
    );
  }
}
