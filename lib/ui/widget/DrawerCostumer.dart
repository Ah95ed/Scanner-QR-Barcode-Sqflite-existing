import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/constant/Constant.dart';
import 'package:scanner_qr_barcode/generated/l10n.dart';
import 'package:sizer/sizer.dart';
import '../../model/stateManagment/provider.dart';
import '../pages/QRViewExample.dart';

class DrawerCostumer extends StatelessWidget {
  const DrawerCostumer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const UserAccountsDrawerHeader(
          arrowColor: ColorUsed.primary,
          accountName: Text(''),
          accountEmail: Text(''),
          // currentAccountPicture: CircleAvatar(
          //   backgroundImage: AssetImage('assets/profile.jpg'),
          // ),
        ),
        ListTile(
          leading: const Icon(
            Icons.calculate_outlined,
            color: Colors.white,
          ),
          title: Text(
            S.of(context).home,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            context
                .read<MainProvider>()
                .manageScreen(context, QRViewExample.route);
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: Text(S.of(context).setting),
          onTap: () {
            // Handle onTap event
          },
        ),
      ],
    );
  }
}
