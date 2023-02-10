import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_qr_barcode/Utils/stateManagment/provider.dart';
import 'package:scanner_qr_barcode/model/User.dart';
import 'package:scanner_qr_barcode/ui/widget/card_view.dart';
import 'AddData.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var rebuild = Provider.of<MainProvider>(context);
    return ChangeNotifierProvider<MainProvider>(
      create: (_) => MainProvider(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 8,
          leading: const Icon(Icons.more_horiz),
          title: const Text('AppBar'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<MainProvider>().lodingData();
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return AddData();
                },
              ),
            );
          },
          tooltip: 'Add',
          backgroundColor: const Color.fromARGB(255, 150, 0, 72),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 32.0,
          ),
        ),
        body: const CardView(),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<User> users = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
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
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var search = context.watch<MainProvider>().search(query);
    var result = context.watch<MainProvider>().todoItem;

    for (User named in result) {
      if (named.name.toLowerCase().contains(query.toLowerCase())) {
        users.add(named);
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

    for (var named in result) {
      if (named.name.toLowerCase().contains(query.toLowerCase())) {
        users.add(named);
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
