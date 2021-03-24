import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchhn/src/provider/state.dart';
import 'package:searchhn/src/screens/home/home.dart';
import 'package:searchhn/src/screens/news_details/news_details.dart';
import 'package:searchhn/src/screens/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => AppState(),
      child: MaterialApp(
        title: 'Search Hacker News',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (_) => SplashScreen(),
          '/home': (_) => HomeScreen(),
          '/details': (_) => NewsDetailsScreen(),
        },
      ),
    );
  }
}
