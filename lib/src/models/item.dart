class ItemDetails {
  final int id;
  final String type;
  final String author;
  final String title;
  final String url;
  final String text;
  final int storyId;
  final List<ItemDetails> children;
  final String error;

  ItemDetails({
    this.id,
    this.type,
    this.author,
    this.title,
    this.url,
    this.text,
    this.storyId,
    this.children,
    this.error,
  });

  factory ItemDetails.fromJson(var json) {
    List children = json['children'];
    List<ItemDetails> parsedChildren = children.map((item) => ItemDetails.fromJson(item)).toList();

    return ItemDetails(
      id: json['id'],
      type: json['type'],
      author: json['author'],
      title: json['title'],
      url: json['url'],
      text: json['text'],
      storyId: json['story_id'],
      children: parsedChildren,
    );
  }
}
