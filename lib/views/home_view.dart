import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import '../observables/state_observable.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/reddit_record_list.dart';

class HomeView extends StatelessWidget {
  final String title;
  const HomeView({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateObservable>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reddit News'),
      ),
      body: Observer(
          builder: (context) => !state.isLoaded
              ? const LoadingIndicator()
              : RefreshIndicator(
                  child: RedditRecordList(
                    redditRecords: state.allReddit,
                  ),
                  onRefresh: () async {
                    await state.reloadRedditAdd();
                  })),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await state.reloadRedditAdd();
        },
        tooltip: 'Reload',
        child: const Icon(Icons.restart_alt),
      ),
    );
  }
}
