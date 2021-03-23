import 'package:flutter/foundation.dart';
import 'package:searchhn/src/models/news_result.dart';

class AppState extends ChangeNotifier {
  bool _isLoading = false;
  List<NewsResult> _newsList = List();

  bool get isLoading => _isLoading;
  List<NewsResult> get newsList => _newsList;

  /// this will simply search the news
  ///
  /// will be used to update the loading behaviour, fetching the news list
  searchNews(String query, {bool shouldNotify = true}) {
    print('$query has been searched');
  }
}
