import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:scanner_qr_barcode/Utils/stateManagment/provider.dart';
import 'package:scanner_qr_barcode/ui/pages/Home.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => MainProvider()),
        )
      ],
      builder: ((context, child) => const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Home(),
          )),
    );
  }
}

class MyRead extends StatefulWidget {
  const MyRead({super.key});

  @override
  State<MyRead> createState() => _MyReadState();
}

class _MyReadState extends State<MyRead> {
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(builder: (context) {
        return Material(
          child: Center(
            child: ElevatedButton(
                onPressed: () {
                  _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                      context: context,
                      onCode: (code) {
                        setState(() {
                          this.code = code;
                        });
                      });
                },
                child: Text(code ?? "Click me")),
          ),
        );
      }),
    );
  }
}
