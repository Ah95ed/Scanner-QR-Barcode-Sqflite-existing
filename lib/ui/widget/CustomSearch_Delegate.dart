import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Utils/stateManagment/provider.dart';
import '../../model/User.dart';

class CustomSearchDelegate extends SearchDelegate {
  late String resultes;
  CustomSearchDelegate({required this.resultes});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          resultes = "";
          context.read<MainProvider>().barcodeScanRes = "";
          context.read<MainProvider>().todoItem.clear();
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        context.read<MainProvider>().todoItem.clear();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    context.watch<MainProvider>().getDataAll();
    var result = context.watch<MainProvider>().todoItem;
    List<User> users = [];
    // query = resultes.toString();
    for (int i = 0; i < result.length; i++) {
      if (result[i].barcode.toLowerCase().contains(resultes.toLowerCase())) {
        users.add(result[i]);
        // break;
      }
    }
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        var result = users[index];
        return ListTile(
          title: Text(result.name),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var result = context.watch<MainProvider>().todoItem;
    context.watch<MainProvider>().getDataAll();
    List<User> users = [];
    for (int i = 0; i < result.length; i++) {
      if (result[i].barcode.toLowerCase().contains(query.toLowerCase())) {
        users.add(result[i]);
        // break;
      }
    }
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        var result = users[index];
        return ListTile(
          title: Text(result.name),
          subtitle: Text(result.sell),
        );
      },
    );
  }
}
