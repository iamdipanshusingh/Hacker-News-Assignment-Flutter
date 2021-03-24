import 'package:flutter/foundation.dart';
import 'package:searchhn/src/api/api_controller.dart';
import 'package:searchhn/src/models/item.dart';
import 'package:searchhn/src/models/results_wrapper.dart';

class AppState extends ChangeNotifier {
  bool _isLoading = false;
  ResultsWrapper _resultsWrapper;
  ItemDetails _newsDetails;

  bool get isLoading => _isLoading;

  ResultsWrapper get resultsWrapper => _resultsWrapper;

  ItemDetails get newsDetails => _newsDetails;

  /// this will simply search the news
  ///
  /// will be used to update the loading behaviour, fetching the news list
  searchNews(String query, {int page, bool shouldNotify = true}) async {
    if (shouldNotify) {
      _isLoading = true;
      notifyListeners();
    }

    _resultsWrapper = await APIController.queryNews(query, page: page);

    /// this will simply remove the redundant item having no title
    _resultsWrapper.newsList.removeWhere((item) => item.title == null || item.title.isEmpty);

    if (shouldNotify) {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// fetches the news details
  fetchNewsDetails(String id, {bool shouldNotify = true}) async {
    if (shouldNotify) {
      _isLoading = true;
      notifyListeners();
    }

    _newsDetails = await APIController.fetchNewsDetails(id);

    if (shouldNotify) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
