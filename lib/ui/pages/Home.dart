import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/constant/Constant.dart';
import 'package:scanner_qr_barcode/generated/l10n.dart';
import 'package:scanner_qr_barcode/ui/pages/UpdatePrice.dart';
import 'package:sizer/sizer.dart';
import '../../model/stateManagment/provider.dart';
import '../widget/CardItems.dart';
import 'AddData.dart';
import 'QRViewExample.dart';

class Home extends StatelessWidget {
  static const String route = '/HOME';
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDrawer();
  }
}

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  final _advancedDrawerController = AdvancedDrawerController();
  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 600;
    final isMobile = MediaQuery.of(context).size.width < 600;
    final provid = context.read<MainProvider>();
    provid.title = Text(S.of(context).mainScreen);
    provid.actionsicon = const Icon(Icons.search);

    return Consumer<MainProvider>(
      builder: (context, value, child) {
        return AdvancedDrawer(
          backdrop: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorUsed.primary,
                  ColorUsed.second,
                ],
              ),
            ),
          ),
          controller: _advancedDrawerController,
          animationCurve: Curves.easeInSine,
          animationDuration: const Duration(milliseconds: 250),
          animateChildDecoration: true,
          rtlOpening: false,
          // openScale: 1.0,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
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
                        provid.manageScreen(context, QRViewExample.route);
                      },
                      leading: const Icon(
                        Icons.calculate_outlined,
                        color: Colors.white,
                      ),
                      title: Text(
                        S.of(context).orders_account,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        provid.exportData(context);
                      },
                      leading: const Icon(
                        Icons.import_export,
                      ),
                      title: Text(
                        S.of(context).export,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        provid.importData();
                      },
                      leading: const Icon(
                        Icons.import_export,
                      ),
                      title: Text(
                        S.of(context).import,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        provid.manageScreen(
                          context,
                          UpdatePrice.route,
                        );
                      },
                      leading: const Icon(
                        Icons.update_outlined,
                        color: Colors.white,
                      ),
                      title: Text(
                        S.of(context).update_prices,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(S.of(context).confirmeDelete),
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        provid.deleteAll();
                                        Navigator.pop(context);
                                      },
                                      child: Text(S.of(context).yes),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(S.of(context).no),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      leading: const Icon(
                        Icons.delete_outlined,
                        color: Colors.white,
                      ),
                      title: Text(
                        S.of(context).delete_all,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        S.of(context).team_policy,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                value.manageScreen(context, AddData.route);
              },
              tooltip: 'Add',
              backgroundColor: ColorUsed.primary,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 5.0,
              toolbarHeight: 10.h,
              actions: [
                IconButton(
                      onPressed: () {
                        value.changeWidget(name: S.of(context).mainScreen);
                      },
                      icon: value.actionsicon,
                    ),
                IconButton(
                  onPressed: () async {
                    await value.openCamera(context);
                  },
                  icon: const Icon(Icons.camera_alt_outlined),
                ),
              ],
              title: value.title,
              leading: isMobile
                  ? IconButton(
                      onPressed: _handleMenuButtonPressed,
                      icon: ValueListenableBuilder<AdvancedDrawerValue>(
                        valueListenable: _advancedDrawerController,
                        builder: (_, value, __) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 190),
                            child: Icon(
                              value.visible ? Icons.clear : Icons.menu,
                              key: ValueKey<bool>(value.visible),
                            ),
                          );
                        },
                      ),
                    )
                  : null ,
              centerTitle: true,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    colors: [ColorUsed.primary, ColorUsed.second],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),

            body: isDesktop ? const CustomBody() : const CardView(),
            // bottomNavigationBar: BottomNavigationBar(
            //   backgroundColor: ColorUsed.primary,
            //   currentIndex: value.currentIndex,
            //   selectedItemColor: Colors.white, // Set the active tab index
            //   onTap: (int index) async {
            //     await value.changeIndex(index, S.of(context).mainScreen);
            //   },
            //   items: [
            //     const BottomNavigationBarItem(
            //       icon: Icon(Icons.home),
            //       label: 'Home',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: value.actionsicon,
            //       label: 'Search',
            //     ),
            //     const BottomNavigationBarItem(
            //       icon: Icon(Icons.settings),
            //       label: 'Settings',
            //     ),
            //   ],
            // ),
          ),
        );
      },
    );
  }
}

class CustomBody extends StatelessWidget {
  const CustomBody({super.key});

  @override
  Widget build(BuildContext context) {
    final provid = context.read<MainProvider>();

    return Row(
      children: [
        const Expanded(
          flex: 4,
          child: CardView(),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: ColorUsed.primary,
            child: ListTileTheme(
              textColor: Colors.white,
              iconColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
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
                      provid.manageScreen(context, QRViewExample.route);
                    },
                    leading: const Icon(
                      Icons.calculate_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      S.of(context).orders_account,
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      provid.exportData(context);
                    },
                    leading: const Icon(
                      Icons.import_export,
                    ),
                    title: Text(
                      S.of(context).export,
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      provid.importData();
                    },
                    leading: const Icon(
                      Icons.import_export,
                    ),
                    title: Text(
                      S.of(context).import,
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      provid.manageScreen(
                        context,
                        UpdatePrice.route,
                      );
                    },
                    leading: const Icon(
                      Icons.update_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      S.of(context).update_prices,
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(S.of(context).confirmeDelete),
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      provid.deleteAll();
                                      Navigator.pop(context);
                                    },
                                    child: Text(S.of(context).yes),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(S.of(context).no),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    leading: const Icon(
                      Icons.delete_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      S.of(context).delete_all,
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      S.of(context).team_policy,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
