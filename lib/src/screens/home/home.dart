import 'package:flutter/material.dart';
import 'package:searchhn/src/utils/const.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Hacker News'),
      ),
      backgroundColor: bgColor,
      body: Column(
        children: [
          Center(
            child: Container(
              width: width * 0.7,
              height: 40,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter your queries here...',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true,

                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    padding: const EdgeInsets.all(0),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
