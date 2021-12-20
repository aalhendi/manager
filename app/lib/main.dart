import 'package:flutter/material.dart';
import 'package:manager/controller/event_notifier.dart';
import 'package:manager/controller/theme_notifier.dart';
import 'package:manager/controller/todo_notifier.dart';
import 'package:manager/view/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TodoNotifier()),
      ChangeNotifierProvider(create: (_) => EventNotifier()),
      ChangeNotifierProvider(create: (_) => ThemeNotifier())
    ],
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
      theme: ThemeNotifier.lightTheme,
      darkTheme: ThemeNotifier.darkTheme,
      themeMode: Provider.of<ThemeNotifier>(context).themeMode,
      home: const Home(),
    );
  }
}
