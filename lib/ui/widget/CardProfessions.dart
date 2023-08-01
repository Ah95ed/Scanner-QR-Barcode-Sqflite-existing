import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../generated/l10n.dart';
import 'Multi_text.dart';

// ignore: must_be_immutable
class CardProfessions extends StatelessWidget {
  // const Professions({super.key});
  String name, sell;

  CardProfessions({
    super.key,
    required this.name,
    required this.sell,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: Colors.blueGrey,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                MultiText(name, S.of(context).name),
                SizedBox(
                  height: 1.h,
                ),
                MultiText(sell, S.of(context).sell),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
