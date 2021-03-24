import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchhn/src/models/news_result.dart';
import 'package:searchhn/src/models/results_wrapper.dart';
import 'package:searchhn/src/provider/state.dart';
import 'package:searchhn/src/utils/const.dart';
import 'package:searchhn/src/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppState>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Search Hacker News'),
      ),
      backgroundColor: bgColor,
      body: Stack(
        children: [
          GestureDetector(
            onPanDown: (_) => FocusScope.of(context).unfocus(),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(height: 20),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10, left: 12, right: 12),
                    height: 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              onSaved: (query) {
                                if (query == null || query.isEmpty) {
                                  Utils.showSnackBar(_scaffoldKey, "There's nothing to search!");
                                } else
                                  provider.searchNews(query);
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter your query here...',
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
                        FlatButton(
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
                          itemCount: resultsWrapper.newsList?.length,
                          itemBuilder: (_, index) {
                            NewsResult newsResult = resultsWrapper.newsList[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/details', arguments: newsResult.id);
                              },
                              child: _newsItemBuilder(newsResult),
                            );
                          },
                        )
                      : Container(
                          height: height * 0.7,
                          child: Center(
                            child: Selector<AppState, String>(
                              selector: (_, provider) => provider.query,
                              builder: (_, query, __) => Text(
                                (query?.isNotEmpty ?? false) ? 'Nothing found!' : 'Begin your search query now!',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
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

  _newsItemBuilder(NewsResult newsResult) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              newsResult.title ?? '-',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            RichText(
              text: TextSpan(
                  text: 'By ' + newsResult.author + ', ',
                  children: [
                    TextSpan(
                      text: newsResult.createdAt,
                      style: TextStyle(color: subtextColor),
                    ),
                    TextSpan(
                      text: ', ${newsResult.numComments ?? '0'} Comments',
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
