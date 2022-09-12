import 'package:flutter/material.dart';
//import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import '../models/reddit_record.dart';
import '../observables/state_observable.dart';
import '../widgets/reddit_record_card.dart';

class RecordView extends StatelessWidget {
  static const routeName = '/record_view';

  final String title;
  final String recordId;

  const RecordView({super.key, required this.title, required this.recordId});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateObservable>(context);
    RedditRecord? record = state.oneRedditById(recordId);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: RedditRecordCard(
        redditRecord: record,
      ),
    );
  }
}
