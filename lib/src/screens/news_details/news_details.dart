import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchhn/src/models/item.dart';
import 'package:searchhn/src/provider/state.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String id;

  const NewsDetailsScreen({Key key, this.id}) : super(key: key);

  @override
  _NewsDetailsScreenState createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  AppState provider;

  @override
  void initState() {
    super.initState();

    provider = Provider.of<AppState>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fetchNewsDetails(widget.id);
    });
  }


  @override
  void dispose() {
    super.dispose();

    provider.setNewsDetails(null, shouldNotify: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, provider, __) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'News Details',
            ),
          ),
          body: !provider.isLoading ? Center(
            child: Text(provider.newsDetails?.title ?? 'This might be a comment'),
          ) : Center(child: CircularProgressIndicator(),),
        ),
      ),
    );
  }
}
