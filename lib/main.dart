import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/provider.dart';
import 'ui/Home.dart';

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
      builder: ((context, child) =>  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      )),
    );
  }
}
