import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:searchhn/src/models/results_wrapper.dart';
import 'package:searchhn/src/utils/const.dart';

class APIController {
  /// [query] - query term searched by the user
  /// [page] - this will determine the page no. user is currently on
  ///
  /// returns list of news results
  static Future<ResultsWrapper> queryNews(String query, {int page}) async {
    final String url = '$SEARCH_URL$query${page != null ? '&page=$page' : ''}';

    final response = await http.get(url);

    final int responseCode = response.statusCode;

    if (responseCode == 200) {
      try {
        var responseBody = json.decode(response.body);

        return ResultsWrapper.fromJson(responseBody);
      } catch (e) {
        return ResultsWrapper(error: e.toString());
      }
    } else {
      return ResultsWrapper(error: 'Something went wrong');
    }
  }
}
