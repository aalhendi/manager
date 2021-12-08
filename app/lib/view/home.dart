import 'package:flutter/material.dart';
import 'package:manager/view/contacts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

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
      drawer: Sidenav(
        selectedIndex: selectedIndex,
        setIndex: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: Builder(builder: (context) {
        if (selectedIndex == 0) {
          return const Center(
            child: Text("1"),
          );
        } else if (selectedIndex == 3) {
          return const Contacts();
        } else {
          return const Center(
            child: Text("data"),
          );
        }
      }),
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
  final int selectedIndex;
  final Function setIndex;

  const Sidenav({Key? key, required this.setIndex, required this.selectedIndex})
      : super(key: key);

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
          Container(
            color: selectedIndex == 0
                ? Theme.of(context).primaryColor.withOpacity(0.125)
                : Colors.transparent,
            child: ListTile(
              title: const Text("Home"),
              selected: selectedIndex == 0,
              leading: IconButton(
                  onPressed: () {
                    setIndex(0);
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.home,
                    color: selectedIndex == 0
                        ? Theme.of(context).primaryColor
                        : Colors.black,
                  )),
            ),
          ),
          Divider(
            color: Colors.grey.shade400,
          ),
          Container(
            color: selectedIndex == 1
                ? Theme.of(context).primaryColor.withOpacity(0.125)
                : Colors.transparent,
            child: ListTile(
              title: const Text("To Do"),
              selected: selectedIndex == 1,
              leading: IconButton(
                  onPressed: () {
                    setIndex(1);
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.list_alt,
                    color: selectedIndex == 1
                        ? Theme.of(context).primaryColor
                        : Colors.black,
                  )),
              // TODO: count incomplete todos
              trailing: const Text(
                "2",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Container(
            color: selectedIndex == 2
                ? Theme.of(context).primaryColor.withOpacity(0.125)
                : Colors.transparent,
            child: ListTile(
              title: const Text("Calendar"),
              selected: selectedIndex == 2,
              leading: IconButton(
                  onPressed: () {
                    setIndex(2);
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.today,
                    color: selectedIndex == 2
                        ? Theme.of(context).primaryColor
                        : Colors.black,
                  )),
            ),
          ),
          Container(
            color: selectedIndex == 3
                ? Theme.of(context).primaryColor.withOpacity(0.125)
                : Colors.transparent,
            child: ListTile(
              title: const Text("Contacts"),
              selected: selectedIndex == 3,
              leading: IconButton(
                  onPressed: () {
                    setIndex(3);
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.contacts,
                    color: selectedIndex == 3
                        ? Theme.of(context).primaryColor
                        : Colors.black,
                  )),
            ),
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
          Container(
            color: selectedIndex == 4
                ? Theme.of(context).primaryColor.withOpacity(0.125)
                : Colors.transparent,
            child: ListTile(
              title: const Text("Settings"),
              selected: selectedIndex == 4,
              leading: IconButton(
                onPressed: () {
                  setIndex(4);
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.settings,
                  color: selectedIndex == 4
                      ? Theme.of(context).primaryColor
                      : Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
