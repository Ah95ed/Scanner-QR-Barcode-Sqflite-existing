import 'package:flutter/material.dart';

import 'QrCode.dart';

class Calcolator extends StatelessWidget {
  const Calcolator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: QRViewExample(),
    );
  }
}
