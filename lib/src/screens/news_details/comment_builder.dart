import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';
import 'package:searchhn/src/models/item.dart';
import 'package:searchhn/src/provider/state.dart';
import 'package:searchhn/src/screens/news_details/comment_line_builder.dart';
import 'package:searchhn/src/utils/const.dart';
import 'package:searchhn/src/utils/utils.dart';

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
      itemBuilder: (_, index) => ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Html(
            data: comments[index].text ?? comments[index].title ?? '-',
            style: {
              '*': Style(textAlign: TextAlign.justify),
            },
            onLinkTap: (url) {
              Utils.launchUrl(url);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  comments[index].author,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  comments[index].createdAt,
                  style: TextStyle(
                    color: subtextColor,
                    fontSize: 13,
                    // fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          (comments[index].children?.isNotEmpty ?? false) ? Selector<AppState, Map>(
            selector: (_, provider) => provider.viewReplyMap,
            builder: (_, viewReplyMap, __) {
              return (viewReplyMap[comments[index].parentId] ?? false)
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20),
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
          ) : Container(),
          Divider(),
        ],
      ),
    );
  }
}
