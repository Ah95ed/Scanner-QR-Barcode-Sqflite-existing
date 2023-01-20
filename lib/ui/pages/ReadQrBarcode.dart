// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// class QRViewExampl extends StatefulWidget {
//   const QRViewExampl({Key? key}) : super(key: key);

//   @override
//   State<QRViewExampl> createState() => _QRViewExampl();
// }

// class _QRViewExampl extends State<QRViewExampl> {
//   String _scanBarcode = 'Unknown';

//   @override
//   void initState() {
//     scanQR();
//     super.initState();
//   }

//   Future<void> startBarcodeScanStream() async {
//     FlutterBarcodeScanner.getBarcodeStreamReceiver(
//             '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
//         .listen((barcode) => print(barcode));
//   }

//   Future<void> scanQR() async {
//     String barcodeScanRes;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//           '#ff6666', 'Cancel', true, ScanMode.QR);
//       print(barcodeScanRes);
//     } on PlatformException {
//       barcodeScanRes = 'Failed to get platform version.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       _scanBarcode = barcodeScanRes;
//     });
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> scanBarcodeNormal() async {
//     String barcodeScanRes;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//           '#ff6666', 'Cancel', true, ScanMode.BARCODE);
//       print(barcodeScanRes);
//     } on PlatformException {
//       barcodeScanRes = 'Failed to get platform version.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       _scanBarcode = barcodeScanRes;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Barcode scan')),
//         body: Builder(
//           builder: (BuildContext context) {
//             return Container(
//                 alignment: Alignment.center,
//                 child: Flex(
//                     direction: Axis.vertical,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       ElevatedButton(
//                           onPressed: () => scanBarcodeNormal(),
//                           child: const Text('Start barcode scan')),
//                       ElevatedButton(
//                           onPressed: () => scanQR(),
//                           child: const Text('Start QR scan')),
//                       ElevatedButton(
//                           onPressed: () => startBarcodeScanStream(),
//                           child: const Text('Start barcode scan stream')),
//                       Text('Scan result : $_scanBarcode\n',
//                           style: const TextStyle(fontSize: 20))
//                     ]));
//           },
//         ),
//       ),
//     );
//   }
// }
