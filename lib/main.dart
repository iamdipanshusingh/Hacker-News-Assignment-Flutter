import 'package:flutter/material.dart';
import 'package:searchhn/src/screens/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Hacker News',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
