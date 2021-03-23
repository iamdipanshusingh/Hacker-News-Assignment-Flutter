import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchhn/src/models/news_result.dart';
import 'package:searchhn/src/models/results_wrapper.dart';
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
      body: Stack(
        children: [
          ListView(
            physics: BouncingScrollPhysics(),
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
              ),
              Selector<AppState, ResultsWrapper>(
                selector: (_, provider) => provider.resultsWrapper,
                builder: (_, resultsWrapper, __) => resultsWrapper != null
                    ? ListView.builder(
                        key: PageStorageKey('search list'),
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: resultsWrapper?.newsList?.length,
                        itemBuilder: (_, index) => _newsItemBuilder(resultsWrapper?.newsList[index]),
                      )
                    : Center(
                        child: Text('Nothing found!'),
                      ),
              ),
            ],
          ),
          Selector<AppState, bool>(
            selector: (_, provider) => provider.isLoading,
            builder: (_, isLoading, __) => isLoading ? Center(child: CircularProgressIndicator()) : Container(),
          ),
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

  /// TODO: implement a better and usable item builder
  _newsItemBuilder(NewsResult newsResult) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(newsResult.title ?? '-'),
            SizedBox(height: 5),
            RichText(
              text: TextSpan(
                  text: 'By ' + newsResult.author,
                  children: [
                    TextSpan(
                      text: ', ' + newsResult.createdAt,
                      style: TextStyle(color: subtextColor),
                    ),
                    TextSpan(
                      text: ', ${newsResult.numComments ?? 'No'} Comments',
                      style: TextStyle(color: subtextColor),
                    ),
                  ],
                  style: TextStyle(color: Colors.black87, fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }
}
