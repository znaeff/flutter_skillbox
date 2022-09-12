import 'package:flutter/material.dart';
import '../views/record_view.dart';
import '../models/reddit_record.dart';

class RedditRecordItem extends StatelessWidget {
  final RedditRecord redditRecord;
  final int index;

  const RedditRecordItem({
    Key? key,
    required this.redditRecord,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(RecordView.routeName,
            arguments: {'rec_id': redditRecord.id});
      },
      tileColor: index.isEven ? Colors.white : Colors.white10,
      leading: redditRecord.thumbnailUrl != null &&
              Uri.parse(redditRecord.thumbnailUrl!).isAbsolute
          ? SizedBox(
              height: 40.0,
              width: 60.0,
              child: Image.network(
                redditRecord.thumbnailUrl!,
                fit: BoxFit.scaleDown,
                height: 40.0,
                width: 60.0,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Text('');
                },
              ),
            )
          : null,
      title: Text(
        redditRecord.title,
      ),
    );
  }
}
