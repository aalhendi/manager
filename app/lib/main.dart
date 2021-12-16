import 'package:flutter/material.dart';
import 'package:manager/controller/todo_notifier.dart';
import 'package:manager/view/home.dart';
import 'package:provider/provider.dart';

// TODO: Add dark mode
void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => TodoNotifier())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
