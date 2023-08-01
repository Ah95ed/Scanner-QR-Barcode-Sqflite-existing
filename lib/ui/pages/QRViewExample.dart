import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scanner_qr_barcode/Utils/constant/Constant.dart';
import 'package:scanner_qr_barcode/Utils/database/DataBaseHelper.dart';
import 'package:scanner_qr_barcode/model/stateManagment/provider.dart';
import 'package:sizer/sizer.dart';



class QRViewExample extends StatelessWidget {
  static const route = '/QRViewExample';

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  DataBaseHelper? _baseHelper;
  QRViewExample({super.key}) {
    _baseHelper = DataBaseHelper();
  }
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   }
  //   controller!.resumeCamera();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, v, child) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Expanded(flex: 6, child: _buildQrView(context)),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          v.resultSell.toString(),
                          style: TextStyle(
                            color: ColorUsed.primary,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            v.clearOrder();
                          },
                          child: Icon(
                            Icons.clear_all,
                            size: 28.sp,
                            color: ColorUsed.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: ListView.builder(
                    itemCount: v.order.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 8,
                        child: ListTile(
                          autofocus: true,
                          title: Text(v.order[index].name),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
final navigatorKey = GlobalKey<NavigatorState>();
  BuildContext? ctx;
  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? MediaQuery.of(context).size.height
        : 280.0.sp;
    ctx = context;


    return Consumer<MainProvider>(
      builder: (context, value, child) {
        return QRView(
          key: qrKey,
          onQRViewCreated: value.onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: ColorUsed.primary,
            borderRadius: 12.sp,
            borderLength: 60.sp,
            borderWidth: 8.sp,
            cutOutSize: scanArea,
          ),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        );
      },
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
