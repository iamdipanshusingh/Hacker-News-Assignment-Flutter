import 'package:searchhn/src/utils/utils.dart';

class NewsResult {
  final String id;
  final String title;
  final String author;
  final int numComments;
  final String createdAt;
  final String error;

  NewsResult({
    this.id,
    this.title,
    this.author,
    this.numComments,
    this.createdAt,
    this.error,
  });

  factory NewsResult.fromJson(var json) {
    return NewsResult(
      id: json['objectID'],
      title: json['title'] ?? json['story_title'],
      author: json['author'],
      numComments: json['num_comments'],
      createdAt: Utils.getDateTimeFromMilliseconds(json['created_at_i']),
    );
  }
}
