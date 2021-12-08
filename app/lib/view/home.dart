import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    showAlertDialog(BuildContext context) {
      /* Button Setup */
      Widget cancelButton = TextButton(
        child: const Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = TextButton(
        child: const Text("Continue"),
        onPressed: () {},
      );

      /* Alert Dialog Setup */
      AlertDialog alert = AlertDialog(
        title: const Text("Alert"),
        content: const Text("Settings Pressed"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      /* Show Dialog */
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.black87,
        leading: Image.asset("images/logo.png"),
        actions: [
          IconButton(
              onPressed: () => {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate())
                  },
              highlightColor: Colors.yellow,
              splashColor: Colors.blue,
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                showAlertDialog(context);
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      drawer: const Sidenav(),
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

class Sidenav extends StatelessWidget {
  const Sidenav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            // TODO: Font selection?
            child: Text(
              "Manager",
              style: TextStyle(
                  fontSize: 21, color: Theme.of(context).primaryColor),
            ),
          ),
          Divider(
            color: Colors.grey.shade400,
          ),
          ListTile(
            title: const Text("Home"),
            leading: IconButton(
                onPressed: () {
                  print("Pressed home");
                },
                icon: const Icon(
                  Icons.home,
                  color: Colors.black,
                )),
          ),
          Divider(
            color: Colors.grey.shade400,
          ),
          ListTile(
            title: const Text("To Do"),
            leading: IconButton(
                onPressed: () {
                  print("Pressed Todo");
                },
                icon: const Icon(
                  Icons.list_alt,
                  color: Colors.black,
                )),
            // TODO: count incomplete todos
            trailing: const Text(
              "2",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          ListTile(
            title: const Text("Calendar"),
            leading: IconButton(
                onPressed: () {
                  print("Pressed Calendar");
                },
                icon: const Icon(
                  Icons.today,
                  color: Colors.black,
                )),
          ),
          ListTile(
            title: const Text("Contacts"),
            leading: IconButton(
                onPressed: () {
                  print("Pressed contacts");
                },
                icon: const Icon(
                  Icons.contacts,
                  color: Colors.black,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "OTHER",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                  letterSpacing: 1),
            ),
          ),
          ListTile(
            title: const Text("Settings"),
            leading: IconButton(
              onPressed: () {
                print("Pressed Settings");
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
