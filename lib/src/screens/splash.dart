import 'package:flutter/material.dart';
import 'package:searchhn/src/screens/home/home.dart';
import 'package:searchhn/src/utils/const.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    /// this will navigate to [HomeScreen] after 3 sec.
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Image.asset('assets/gifs/hn.gif'),
      ),
    );
  }
}
