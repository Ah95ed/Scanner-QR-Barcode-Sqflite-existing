import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Utils/stateManagment/provider.dart';
import '../../model/User.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          context.read<MainProvider>().todoItem.clear();
          query = '';
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
    for (int i = 0; i < result.length; i++) {
      if (result[i].name.toLowerCase().contains(query.toLowerCase())) {
        users.add(result[i]);
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
      if (result[i].name.toLowerCase().contains(query.toLowerCase())) {
        users.add(result[i]);
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
