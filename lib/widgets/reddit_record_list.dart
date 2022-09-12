import 'package:flutter/material.dart';
import '../models/reddit_record.dart';
import 'reddit_record_item.dart';

class RedditRecordList extends StatelessWidget {
  final List<RedditRecord> redditRecords;

  const RedditRecordList({
    required this.redditRecords,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: redditRecords.length,
      itemBuilder: (BuildContext context, int index) {
        final rr = redditRecords[index];
        return RedditRecordItem(
          redditRecord: rr,
          index: index,
        );
      },
    );
  }
}
