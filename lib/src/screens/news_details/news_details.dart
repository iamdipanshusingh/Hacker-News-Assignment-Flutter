import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchhn/src/models/item.dart';
import 'package:searchhn/src/provider/state.dart';
import 'package:searchhn/src/utils/utils.dart';

import 'comment_builder.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String id;

  const NewsDetailsScreen({Key key, this.id}) : super(key: key);

  @override
  _NewsDetailsScreenState createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  AppState provider;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    provider = Provider.of<AppState>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fetchNewsDetails(widget.id);
    });
  }

  @override
  void dispose() {
    super.dispose();

    provider.setNewsDetails(null, shouldNotify: false);
    provider.updateViewCommentsMap(null, shouldNotify: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, provider, __) {
        ItemDetails newsDetails = provider.newsDetails;

        return SafeArea(
          key: _scaffoldKey,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Hacker News',
              ),
            ),
            body: !provider.isLoading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: [
                        Text(
                          newsDetails?.title ?? '',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            text: 'Author: ',
                            children: [
                              TextSpan(
                                text: newsDetails?.author,
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        if (newsDetails?.text != null && (newsDetails?.text?.isNotEmpty ?? true)) Text(newsDetails?.text),
                        if (newsDetails?.url != null && (newsDetails?.url?.isNotEmpty ?? true))
                          GestureDetector(
                            onTap: () async {
                              bool result = await Utils.launchUrl(newsDetails?.url);
                              if (!result) {
                                Utils.showSnackBar(_scaffoldKey, 'Invalid URL!');
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text('Click here to open link'),
                            ),
                          ),
                        Divider(),
                        (newsDetails?.children == null || (newsDetails?.children?.length ?? 0) == 0) ? Text('No comments available') : Text('${newsDetails?.children?.length} comments'),
                        SizedBox(height: 10),
                        (newsDetails?.children != null && (newsDetails?.children?.length ?? 0) > 0) ? CommentsBuilder(comments: newsDetails?.children) : Container()
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        );
      },
    );
  }
}
