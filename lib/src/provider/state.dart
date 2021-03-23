import 'package:flutter/foundation.dart';
import 'package:searchhn/src/api/api_controller.dart';
import 'package:searchhn/src/models/results_wrapper.dart';

class AppState extends ChangeNotifier {
  bool _isLoading = false;
  ResultsWrapper _resultsWrapper;

  bool get isLoading => _isLoading;

  ResultsWrapper get resultsWrapper => _resultsWrapper;

  /// this will simply search the news
  ///
  /// will be used to update the loading behaviour, fetching the news list
  searchNews(String query, {int page, bool shouldNotify = true}) async {
    if (shouldNotify) {
      _isLoading = true;
      notifyListeners();
    }

    _resultsWrapper = await APIController.queryNews(query, page: page);

    if (shouldNotify) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
