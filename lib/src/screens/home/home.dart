import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchhn/src/provider/state.dart';
import 'package:searchhn/src/utils/const.dart';

class HomeScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final width = size.width;
    final provider = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Hacker News'),
      ),
      backgroundColor: bgColor,
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        onSaved: (query) => provider.searchNews(query),
                        validator: (value) => value == null || value.trim().isEmpty ? "This field can't be empty" : null,
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
                  ),
                  Container(
                    height: 48,
                    child: FlatButton(
                      onPressed: _validateInput,
                      padding: const EdgeInsets.all(0),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.white,
                        ),
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

  /// validates the input and saves the entered query
  ///
  /// the entered query on being saved, will search the news on its own
  /// see [searchNews()] method in state.dart
  void _validateInput() {
    final formState = _formKey.currentState;
    
    if (formState.validate()) {
      formState.save();
    }
  }
}
