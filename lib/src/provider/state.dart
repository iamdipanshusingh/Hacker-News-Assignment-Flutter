import 'package:flutter/foundation.dart';
import 'package:searchhn/src/api/api_controller.dart';
import 'package:searchhn/src/models/item.dart';
import 'package:searchhn/src/models/news_result.dart';
import 'package:searchhn/src/models/results_wrapper.dart';

class AppState extends ChangeNotifier {
  int _page;
  String _query;
  bool _isLoading = false;
  bool _showFAB = false;
  ResultsWrapper _resultsWrapper;
  ItemDetails _newsDetails;
  List<NewsResult> _newsList = List();
  Map _viewReplyMap = Map();

  int get page => _page;

  String get query => _query;

  bool get isLoading => _isLoading;

  bool get showFAB => _showFAB;

  ResultsWrapper get resultsWrapper => _resultsWrapper;

  ItemDetails get newsDetails => _newsDetails;

  List<NewsResult> get newsList => _newsList;

  Map get viewReplyMap => _viewReplyMap;

  /// this will simply search the news
  ///
  /// will be used to update the loading behaviour, fetching the news list
  searchNews(String query, {int page, bool shouldNotify = true}) async {
    _query = query;

    if (shouldNotify) {
      _isLoading = true;
      notifyListeners();
    }

    try {
      final resultsWrapper = await APIController.queryNews(query, page: page);
      _page = resultsWrapper.page + 1;

      /// this will simply remove the redundant item having no title
      resultsWrapper.newsList.removeWhere((item) => item.title == null || item.title.isEmpty);

      if (page != null) {
        List<NewsResult> oldNewsList = List.from(_resultsWrapper.newsList);
        oldNewsList.addAll(resultsWrapper.newsList);

        _newsList = oldNewsList;
      } else {
        _newsList = resultsWrapper.newsList;
      }
      _resultsWrapper = resultsWrapper;
    } catch (_) {
      if (shouldNotify) {
        _isLoading = false;
        notifyListeners();
      }
    }

    if (shouldNotify) {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// fetches the news details
  fetchNewsDetails(id, {bool shouldNotify = true, bool notifyLater = false}) async {
    if (id == null) {
      _newsDetails = ItemDetails(error: 'Please provide a valid ID');
      if (shouldNotify) notifyListeners();
      return;
    }

    if (!notifyLater && shouldNotify) {
      _isLoading = true;
      notifyListeners();
    }

    try {
      _newsDetails = await APIController.fetchNewsDetails(id);

      /// if the news type is not a story... then fetch the story of it
      if (_newsDetails.type != 'story') {
        fetchNewsDetails(_newsDetails.storyId, notifyLater: true);
        return;
      }
    } catch (_) {
      if (notifyLater || shouldNotify) {
        _isLoading = false;
        notifyListeners();
      }
    }

    if (notifyLater || shouldNotify) {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// explicitly sets the news details
  setNewsDetails(ItemDetails itemDetails, {bool shouldNotify = true}) {
    _newsDetails = itemDetails;

    if (shouldNotify) notifyListeners();
  }

  /// update the viewed comments list here
  ///
  /// this will set the viewed comments' status
  /// initially, they'll be null -> not viewed yet [_viewReplyMap] => {}
  /// when they're clicked -> map will have their respective data => {parent_id: true}
  ///
  /// once a value is set to true will remain true -> on back press [_viewReplyMap] will be reset
  updateViewCommentsMap(Map data, {bool shouldNotify = true}) {
    if (data == null)
      _viewReplyMap = Map();
    else
      _viewReplyMap[data.keys.first] = data.values.first;

    if (shouldNotify) notifyListeners();
  }

  setFAB(bool value, {bool shouldNotify = true}) {
    if (value == _showFAB) return;

    _showFAB = value;

    if (shouldNotify) notifyListeners();
  }

  incrementPage({bool shouldNotify = true}) {
    _page ??= 1;

    if (_resultsWrapper.pages <= _page) {
      _page = resultsWrapper.page + 1;
      return;
    }

    _page++;

    searchNews(_query, page: _page, shouldNotify: shouldNotify);
  }
}
