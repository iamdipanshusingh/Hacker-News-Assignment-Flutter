import 'package:searchhn/src/models/news_result.dart';

class ResultsWrapper {
  final List<NewsResult> newsList;
  final int totalHits;
  final int page;
  final int hitsPerPage;
  final String error;

  ResultsWrapper({
    this.newsList,
    this.totalHits,
    this.page,
    this.hitsPerPage,
    this.error,
  });

  factory ResultsWrapper.fromJson(var json) {
    List newsList = json['hits'] ?? List();

    return ResultsWrapper(
      newsList: newsList.map((item) => NewsResult.fromJson(item)).toList(),
      totalHits: json['nbHits'],
      page: json['page'],
      hitsPerPage: json['hitsPerPage'],
    );
  }
}
