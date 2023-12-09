import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/ui/pages/AddData.dart';
import 'package:scanner_qr_barcode/ui/pages/EditData.dart';
import 'package:scanner_qr_barcode/ui/pages/Home.dart';
import 'package:scanner_qr_barcode/ui/pages/ShowInformation.dart';
import 'package:scanner_qr_barcode/ui/pages/QRViewExample.dart';
import 'package:scanner_qr_barcode/ui/pages/UpdatePrice.dart';
import 'package:sizer/sizer.dart';
import 'package:scanner_qr_barcode/model/stateManagment/provider.dart';
import 'generated/l10n.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orSize, deviceType) {
        return MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          initialRoute: Home.route,
          routes: {
            Home.route: (context) => const Home(),
            ShowInformation.route: (context) => ShowInformation(),
            QRViewExample.route: (context) => const QRViewExample(),
            AddData.route: (context) => AddData(),
            UpdatePrice.route: (context) => UpdatePrice(),
            EditData.route: (context) => EditData(),
          },
          navigatorKey: navigatorKey,
        );
      },
    );
  }
}
