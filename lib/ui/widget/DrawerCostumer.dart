import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../model/stateManagment/provider.dart';
import '../pages/QRViewExample.dart';
    
class DrawerCostumer extends StatelessWidget {
  const DrawerCostumer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(
            Icons.calculate_outlined,
            color: Colors.white,
          ),
          title: Text(
            'Home',
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
          title: const Text('Settings'),
          onTap: () {
            // Handle onTap event
          },
        ),
      ],
    );
  }
}