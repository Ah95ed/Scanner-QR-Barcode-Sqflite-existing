import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Qr extends Widget {
  const Qr({Key? key}) : super(key: key);

  @override
  Element createElement() {
    // TODO: implement createElement
    throw UnimplementedError();
  }

  Future<void> openCamera() async {
    String barcodeScanRes;
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
   
  }
}
