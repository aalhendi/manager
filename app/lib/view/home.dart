import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  const Home({Key? key}) : super(key: key);
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Home"),
      actions: [
        IconButton(
            onPressed: () => {
                  showSearch(context: context, delegate: CustomSearchDelegate())
                },
            icon: const Icon(Icons.search))
      ],
    ),
  );
}
}

class CustomSearchDelegate extends SearchDelegate {
  // TODO: Feed suggestions
  // TODO: Refactor into files and folders
  List<String> searchTerms = ['a', 'b'];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
                query = '';
              },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var query in searchTerms) {
      if (query.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(query);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var query in searchTerms) {
      if (query.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(query);
      }
    }
        return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }
}