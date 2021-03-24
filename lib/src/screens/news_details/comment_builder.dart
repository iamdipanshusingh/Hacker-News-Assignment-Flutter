import 'package:flutter/material.dart';
import 'package:searchhn/src/models/item.dart';
import 'package:searchhn/src/screens/news_details/comment_line_builder.dart';

/// this will simply build the comment section in a nested way
class CommentsBuilder extends StatelessWidget {
  final List<ItemDetails> comments;

  const CommentsBuilder({Key key, this.comments})
      : assert(comments != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: comments.length,
      itemBuilder: (_, index) => ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Text(comments[index].text ?? comments[index].title ?? '-'),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CustomPaint(
              painter: CommentLineBuilder(),
              child: CommentsBuilder(comments: comments[index].children),
            ),
          ),
        ],
      ),
    );
  }
}
