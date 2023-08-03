import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../model/stateManagment/provider.dart';

class DeleteDailog extends StatelessWidget {
  MainProvider v;
  int index;
  DeleteDailog({
    Key? key,
    required this.v,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //add dialog to update data
      title: Text(S.of(context).confirmeDelete),
      actions: [
        TextButton(
          child: Text(S.of(context).yes),
          onPressed: () {
            v.deleteData(
              v.todoItem[index].id,
            );
            v.todoItem.clear();
            v.paginationData();
            Navigator.of(context).pop();
            // rebuildUi();
          },
        ),
        const SizedBox(
          width: double.minPositive,
        ),
        TextButton(
          onPressed: () => {Navigator.of(context).pop()},
          child: Text(S.of(context).no),
        )
      ],
    );
  }
}
