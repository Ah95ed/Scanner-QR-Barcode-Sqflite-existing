import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scanner_qr_barcode/Utils/constant/Constant.dart';
import 'package:scanner_qr_barcode/model/stateManagment/provider.dart';
import 'package:sizer/sizer.dart';
import '../../generated/l10n.dart';

class QRViewExample extends StatefulWidget {
  static const route = '/QRViewExample';

  const QRViewExample({super.key});

  @override
  State<QRViewExample> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows) {
      return Consumer<MainProvider>(
        builder: (context, v, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorUsed.primary,
              actions: [
                IconButton(
                  onPressed: () {
                    v.changeWidgetInOrder(name: 'ahmed');
                  },
                  icon: v.actionsicon ,
                )
              ],
              title: v.title,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  flex: 6,
                  child: ListView.builder(
                    itemCount: v.searchList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white54,
                        elevation: 8,
                        child: ListTile(
                          autofocus: true,
                          title: Text(v.searchList[index].name),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
    return Consumer<MainProvider>(
      builder: (context, v, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorUsed.primary,
              actions: [
                IconButton(
                  onPressed: () {
                    v.changeWidget(name: S.of(context).orders_account);
                  },
                  icon: v.actionsicon,
                )
              ],
              title: v.title,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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

  void _onPermissionSet(
    BuildContext context,
    QRViewController ctrl,
    bool p,
  ) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
