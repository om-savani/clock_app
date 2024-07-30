import 'package:clock_app/screens/clockpage.dart';
import 'package:clock_app/screens/homepage.dart';
import 'package:clock_app/screens/stopwatch.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const Homepage(),
        "clock_page": (context) => const Clockpage(),
        "stop_watch": (context) => const StopWatch()
      },
    );
  }
}
