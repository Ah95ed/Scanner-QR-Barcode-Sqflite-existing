import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/constant/Constant.dart';
import 'package:scanner_qr_barcode/generated/l10n.dart';
import 'package:sizer/sizer.dart';

import '../../model/stateManagment/provider.dart';
import '../widget/card_view.dart';
import 'AddData.dart';
import 'QRViewExample.dart';

class Home extends StatelessWidget {
  static const String route = '/HOME';
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<MainProvider>().paginationData();
    return CustomDrawer();
  }
}

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  final _advancedDrawerController = AdvancedDrawerController();
  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();

    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final provid = context.read<MainProvider>();
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorUsed.primary, ColorUsed.second,
              // Colors.blueGrey,
              // Colors.blueGrey.withOpacity(0.2),
            ],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInSine,
      animationDuration: const Duration(milliseconds: 1000),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.white,
            blurRadius: 0.0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Container(
          color: ColorUsed.primary,
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 0,
                  height: 0,
                  margin: const EdgeInsets.only(
                    top: 18.0,
                    bottom: 10.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                ),
                ListTile(
                  onTap: () {
                    context
                        .read<MainProvider>()
                        .manageScreen(context, QRViewExample.route);
                  },
                  leading: const Icon(
                    Icons.calculate_outlined,
                    color: Colors.white,
                  ),
                  title: Text(S.of(context).orders_account),
                ),
                ListTile(
                  onTap: () async {
                    provid.exportData(context);
                  },
                  leading: Icon(
                    Icons.import_export,
                    size: 24.sp,
                  ),
                  title: Text(S.of(context).export),
                ),
                ListTile(
                  onTap: () async {
                    await Permission.storage.request();
                    await Permission.manageExternalStorage.request();
                    final p = await Permission.accessMediaLocation.request();
                    if (p.isGranted) {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.any,
                        allowedExtensions: ['csv'],
                      );
                      if (result != null) {
// ! Here to save data in sqflite // TOD;
                      }
                    }
                  },
                  leading: Icon(
                    Icons.import_export,
                    size: 24.sp,
                  ),
                  title: Text(S.of(context).import),
                ),
                const Spacer(),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text(
                      S.of(context).team_policy,
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      child: Consumer<MainProvider>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(
              title: value.title,
              backgroundColor: ColorUsed.primary,
              leading: IconButton(
                onPressed: _handleMenuButtonPressed,
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: _advancedDrawerController,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Icon(
                        value.visible ? Icons.clear : Icons.menu,
                        key: ValueKey<bool>(value.visible),
                      ),
                    );
                  },
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    value.changeWidget();
                  },
                  icon: value.actionsicon,
                ),
                IconButton(
                  onPressed: () async {
                    await context.read<MainProvider>().openCamera(context);
                  },
                  icon: const Icon(Icons.camera_alt_outlined),
                ),
              ],
            ),
            body: CardView(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                value.manageScreen(context, AddData.route);
              },
              tooltip: 'Add',
              backgroundColor: ColorUsed.primary,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20.0.sp,
              ),
            ),
          );
        },
      ),
    );
  }
}
