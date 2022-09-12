import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../models/reddit_record.dart';

class RedditRecordCard extends StatelessWidget {
  final RedditRecord? redditRecord;

  const RedditRecordCard({
    Key? key,
    required this.redditRecord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            title:
                Text(redditRecord != null ? redditRecord!.title : 'no title'),
            trailing: Text(
              '▲ ${redditRecord != null ? redditRecord!.ups.toString() : '0'}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MarkdownBody(
                  data: redditRecord != null
                      ? redditRecord!.selftext
                      : 'no title',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
