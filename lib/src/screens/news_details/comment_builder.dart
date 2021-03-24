import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchhn/src/models/item.dart';
import 'package:searchhn/src/provider/state.dart';
import 'package:searchhn/src/screens/news_details/comment_line_builder.dart';

/// this will simply build the comment section in a nested way
class CommentsBuilder extends StatelessWidget {
  final List<ItemDetails> comments;

  const CommentsBuilder({Key key, this.comments})
      : assert(comments != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: comments.length,
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.only(left: 10),
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Text(comments[index].text ?? comments[index].title ?? '-'),
            Divider(),
            Selector<AppState, Map>(
              selector: (_, provider) => provider.viewReplyMap,
              builder: (_, viewReplyMap, __) {
                return (viewReplyMap[comments[index].parentId] ?? false)
                    ? Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: CustomPaint(
                          painter: CommentLineBuilder(),
                          child: CommentsBuilder(comments: comments[index].children),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          Map data = {comments[index].parentId: true};

                          provider.updateViewCommentsMap(data);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'View Reply',
                            style: TextStyle(color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
